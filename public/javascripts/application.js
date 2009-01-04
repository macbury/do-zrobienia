// By MacBury

window.load = function () {
	$$('#udostepnienie_form input[type="radio"]').each(function (radio) {
		radio.click = function () {
			var aktywne = (this.name == 'lista[udostepnienie]');
			$("lista_pokaz_czas_ukonczenia").disabled = aktywne;
			$("lista_pokaz_w_publicznych").disabled = aktywne;
		}).bind(this);
	});
}

function pokaz_ukryj(ukryj,pokaz){
	$(ukryj).hide();
	$(pokaz).show();
}

function ajax_error(transport) {
   //rawText = transport.responseText;
   alert('Nie można dodać zadania!');
}

function zadanie_form_switch(nieaktywne){
	$("zadania_form").disabled = nieaktywne;
}


function toggle_zadanie(id, lista_id){
	new Ajax.Request('/zadania/toggle/'+id+'?lista_id='+lista_id, 
					{asynchronous:true, 
						evalScripts:true, 
							onLoading:function(request)
							{
									$('check_'+id).hide(); 
									$('spinner_'+id).show();
							}, 
						  parameters:'authenticity_token=' + encodeURIComponent(form_auth_token)})
}

function usun_zadanie(id, lista_id){
	if (confirm('Czy na pewno chcesz usunąć te zadanie?')) 
	{ 
		new Ajax.Request('/listy/'+lista_id+'/zadania/'+id, 
					{
					 asynchronous:true, 
						evalScripts:true, 
								 method:'delete', 
						 onComplete:function(request)
							{
								new Effect.Fade('zadanie_'+id); 
								new Effect.BlindUp('zadanie_'+id);
							}, 
						 onLoading:function(request)
							{
								$('del_'+id).hide(); 
								$('check_'+id).hide(); 
								$('spinner_'+id).show();
							}, 
							parameters:'authenticity_token=' + encodeURIComponent(form_auth_token)
					}); 
	}; 
	return false;
}

function sortuj_zadania(lista_id){
	sortuj = null
	sortuj = Sortable.create("do_zrobienia", 
				{
				 handle:'drag',
						tag:'p',
			 onUpdate:function()
						{
							new Ajax.Request('/zadania/order?lista_id='+lista_id, 
											{
												asynchronous:true, 
												evalScripts:true, 
												parameters:Sortable.serialize("do_zrobienia") + '&authenticity_token=' + encodeURIComponent(form_auth_token)
											})
						}
				});
}

function aktualizuj_zadanie(id, lista_id){
	new Ajax.InPlaceEditor('zadanie_'+id+'_nazwa', '/listy/'+lista_id+'/zadania/'+id+'.json', 
	{ 
        ajaxOptions: { method: 'put' },
        cancelText: 'anuluj',
        savingText: 'Zapisuję...',
				size: 60,
        callback: function(form, value) 
          { return 'authenticity_token='+encodeURIComponent(form_auth_token)+'&zadanie[nazwa]=' + encodeURIComponent(value) },
        onComplete: function(transport, element) 
          { element.innerHTML=transport.responseText.evalJSON().nazwa;},
				onFailure: function(transport) { ajax_error(transport) } 
	});
}

function zmien_tag(name,id) {
	$$('.tags li').each(
			function(value, index) {
					value.removeClassName('selected');
			});
	$('tag_'+id).addClassName('selected');
	
	new Ajax.Updater('listy','/listy/tag?tag_id='+name,
					{
						asynchronous:true, 
						evalScripts:true, 
						method: 'get',
						parameters:'&authenticity_token=' + encodeURIComponent(form_auth_token)
					})
}