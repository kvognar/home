FactoryGirl.define do
  factory :day do
    title "Photo"
    body "A long and meandering description of the mote of dust that hovered in front of my eyes this morning."
    mouseover "Extra thought about how the dust might have once been an eyelash or a fly wing or a bit of banana peel."
    lyrics "lost in the clouds"
    lyric_credit "The Transfiguration - Sufjan Stevens"
    sequence :whisper do |n|
      "secret inside jokes #{n}"
    end
    day_of Date.today
    sequence :number do |n|
      n
    end
  end
end
