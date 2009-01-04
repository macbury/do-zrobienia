{
  :pl => {
    # date and time formats
    :date => {
      :formats => {
        :default      => "%Y-%m-%d",
        :short        => "%e %b",
        :long         => "%B %e, %Y",
        :long_ordinal => lambda { |date| "%B #{date.day}, %Y" },
        :only_day     => lambda { |date| "#{date.day}"}
      },
      :day_names => %w(Niedziela Poniedziałek Wtorek Środa Czwartek Piątek Sobota),
      :abbr_day_names => %w(Niedz Pon Wt Śr Czw Pią Sob),
      :month_names => [nil] + %w(Styczeń Luty Marzec Kwiecien Maj Czerwiec
                                 Lipiec Siepień Wrześień Październik Listopad Grudzień),
      :abbr_month_names => [nil] + %w(Sty Lut Mar Kwi Maj Czer Lip Sier Wrze Paź Lis Gru),
      :order => [:day, :month, :year]
    },
    :time => {
      :formats => {
        :default      => "%a %b %d %H:%M:%S %Z %Y",
        :time         => "%H:%M",
        :short        => "%d %b %H:%M",
        :long         => "%B %d, %Y %H:%M",
        :long_ordinal => lambda { |time| "%B #{time.day}ish, %Y %H:%M" },
        :only_second  => "%S"
      },
        :datetime => {
          :formats => {
            :default => "%Y-%m-%dT%H:%M:%S%Z"
          }
        },
        :time_with_zone => {
          :formats => {
            :default => lambda { |time| "%Y-%m-%d %H:%M:%S #{time.formatted_offset(false, 'UTC')}" }
          }
        },
      :am => nil,
      :pm => nil
    },

    # date helper distance in words
    :datetime => {
      :distance_in_words => {
        :half_a_minute       => 'pół minuty',
        :less_than_x_seconds => {:zero => 'mniej niż sekunde', :one => 'mniej niż 1 sekunde', :other => 'mniej niż {{count}} sekund'},
        :x_seconds           => {:one => '1 sekunda', :other => '{{count}} sekund'},
        :less_than_x_minutes => {:zero => 'mniej niż minuta', :one => 'mniej niż 1 minuta', :other => 'mniej niż {{count}} minut'},
        :x_minutes           => {:one => "1 minuta", :two => "2 minuty",:three => "3 minuty",:four => "4 minuty", :other => "{{count}} minut"},
        :about_x_hours       => {:one => 'około 1 godziny', :other => 'około {{count}} godzin'},
        :x_days              => {:one => '1 dzień', :other => '{{count}} dni'},
        :about_x_months      => {:one => 'około 1 miesiąca', :other => 'około {{count}} miesięcy'},
        :x_months            => {:one => '1 miesiąc', :two => "2 miesiące",:three => "3 miesiące",:four => "4 miesiące", :other => '{{count}} miesięcy'},
        :about_x_years       => {:one => 'około 1 roku', :other => 'około {{count}} lat'},
        :over_x_years        => {:one => 'ponad 1 rok', :other => 'ponad {{count}} lat'}
      }
    },

    # numbers
    :number => {
      :format => {
        :precision => 3,
        :separator => ',',
        :delimiter => '.'
      },
      :currency => {
        :format => {
          :unit => 'zł',
          :precision => 2,
          :format => '%n %u'
        }
      }
    },

    # Active Record
    :activerecord => {
      :errors => {
        :template => {
          :header => {
            :one => "Nie można zapisać {{model}}: 1 błąd", 
            :two => "Nie można zapisać {{model}}: 2 błędy", 
            :three => "Nie można zapisać {{model}}: 3 błędy",
            :four => "Nie można zapisać {{model}}: 4 błędy",
            :other => "Nie można zapisać {{model}}: {{count}} błędów."
          },
          :body => "Sprawdź następujące pola"
        },
        :messages => {
          :inclusion => "ain't included in the list",
          :exclusion => "nie jest dostępne",
          :invalid => "nie jest prawidłowy",
          :confirmation => "nie odpowiada wartości we wcześniejszym polu",
          :accepted  => "musi być zaakceptowane",
          :empty => "nie może być puste",
          :blank => "musi być podane",
          :too_long => "jest za długie (nie więcej niż {{count}} znaków)",
          :too_short => "jest za krótkie (nie mniej niż {{count}} znaków)",
          :wrong_length => "nie jest prawidłowej długości (musi mieć {{count}} znaków)",
          :taken => "jest już zajęty",
          :not_a_number => "nie jest liczbą",
          :greater_than => "musi być większe niż {{count}}",
          :greater_than_or_equal_to => "musi być większe lub równe {{count}}",
          :equal_to => "musi być równe {{count}}",
          :less_than => "musi być mniej niż {{count}}",
          :less_than_or_equal_to => "musi być mniejsze lub równe {{count}}",
          :odd => "musi być nieparzysty"
        }
      }
    }
  }
}