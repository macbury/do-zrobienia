
module ApplicationHelper
  def error_for(object,attr,srednik = true)
    blad = object.errors.on(attr)
    return if blad.nil?
    wynik = "";
    wynik += " - " if srednik
    blad.each do |tresc|
      wynik += "<span style=\"color: red\">#{tresc} </span>"
    end
    return wynik
  end
  
  def error_for_table(object, attr, cols = 2)
    content_tag(:tr, 
      content_tag(:td, error_for(object,attr,false), :colspan => cols, :style => "text-align:center" )
    )
  end
  
  def distance_of_time_in_words_pl(from_time)
    from_time = from_time.to_time if from_time.respond_to?(:to_time)
    to_time = Time.now
    distance_in_minutes = (((to_time - from_time).abs)/60).round
    distance_in_seconds = ((to_time - from_time).abs).round

    case distance_in_minutes
        when 0..1
          case distance_in_seconds
            when 0..4   then 'mniej niż 5 sekund'
            when 5..9   then 'mniej niż 10 sekund'
            when 10..19 then 'mniej niż 20 sekund'
            when 20..39 then 'pół minuty'
            when 40..59 then 'mniej niż minutę'
            else             'minutę'
          end

        when 2..4           then "#{distance_in_minutes} minuty"
        when 5..44           then "#{distance_in_minutes} minut"
        when 45..89          then 'około godziny'
        when 90..1439        then "#{(distance_in_minutes.to_f / 60.0).round} godzin"
        when 1440..2879      then '1 dzień'
        when 2880..43199     then "#{(distance_in_minutes / 1440).round} dni"
        when 43200..86399    then 'około 1 miesiąca'
        when 86400..525599   then "#{(distance_in_minutes / 43200).round} months"
        when 525600..1051199 then 'około 1 roku'
        else                      "ponad #{(distance_in_minutes / 525600).round} lat"
      end
  end   
   
end