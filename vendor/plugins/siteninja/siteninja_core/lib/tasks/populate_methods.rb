if Rails.env.production?
  cms_config = YAML::load_file("#{RAILS_ROOT}/config/cms.yml")
  $DOMAIN_PATH = "http://#{cms_config['website']['domain']}"
else
  $DOMAIN_PATH = "http://localhost:3000"
end    

def random_video_url
  $VIDEO_URLS[rand($VIDEO_URLS.size)]
end

def random_pirate_paragraphs(at_least=1, at_most=3, for_html=false)
  o = ''
  (rand(at_most)+at_least).times do
    random_paragraph = $PIRATE_PARAGRAPHS[rand($PIRATE_PARAGRAPHS.size)]
    if for_html
      o << "<p>#{random_paragraph}</p>\n\n"
    else
      o << "#{random_paragraph}\n\n"
    end
  end
  o # return content
end

def random_pirate_sentence
  $PIRATE_SENTENCES[rand($PIRATE_SENTENCES.size)]
end

def random_asset_url
  assets ||= Asset.all
  asset_url = assets.sort_by(&:rand).first.file.url(:small)
  "#{$DOMAIN_PATH}#{asset_url}"
end

def random_asset_or_video_url(for_html=false)
  random_url = (rand(2) == 0 ? random_video_url : random_asset_url)
  if for_html
    "<p>#{random_url}</p>\n\n"
  else
    "#{random_url}\n\n"
  end
end

def generate_random_body_content(for_html=false)
  o = ''
  $BLURB = random_pirate_paragraphs(1,1,for_html)
  o << $BLURB
  first_random_asset = random_asset_or_video_url(for_html)
  o << first_random_asset

  # sometimes put the embedded video in the blurb (video only, not images)
  $BLURB << first_random_asset if !first_random_asset.match(/(vimeo|youtube)/).nil? and rand(2) == 0
  
  # set description to random sentence
  $DESCRIPTION = random_pirate_sentence
  
  o << random_pirate_paragraphs(1,3,for_html)
  if rand(2) == 0 # extra long content!
    o << random_asset_or_video_url(for_html)
    o << random_pirate_paragraphs(1,3,for_html)
  end
  if rand(2) == 0 # extra long content!
    o << random_asset_or_video_url(for_html)
    o << random_pirate_paragraphs(1,4,for_html)
  end
  if rand(5) == 0 # extra extra long content!
    o << random_asset_or_video_url(for_html)
    o << random_pirate_paragraphs(1,5,for_html)
  end
  o
end

def pick_tags
  my_tags = []
  (rand(3)+1).times { my_tags << $TAG_PHRASES[rand($TAG_PHRASES.size)] }
  my_tags.join(', ')
end

def make_permalink(x)
  x.gsub(/\W/, ' ').strip.downcase.gsub(/\ +/, '-')
end

def make_comma_list
  comma_list = []
  (rand(2)+1).times { comma_list << Populator.words(1..2).downcase }
  comma_list.join(', ')
end

def make_tags(x)
  puts 'Assigning tags...'
  for r in x
    r.tag_list = pick_tags
    r.save
  end
end
