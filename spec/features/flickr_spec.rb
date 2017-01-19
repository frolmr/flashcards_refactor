require 'rails_helper'
require 'spec_helper'
require 'support/helpers/login_helper.rb'
include LoginHelper


describe Dashboard::CardsController do
  card = Card.create(original_text: '', translated_text: 'house', user_id: 1, block_id: 1)
  context 'Flickr find button' do
    let(:photos_list) {
      [
        { "id": "31975369950", "owner": "93207294@N04", "secret": "6e4c522462", "server": "549", "farm": 1, "title": "Mini 1000 - 1982", "ispublic": 1, "isfriend": 0, "isfamily": 0 },
        { "id": "31975369410", "owner": "93207294@N04", "secret": "94fff1ecbe", "server": "512", "farm": 1, "title": "Mini 1000 - 1982", "ispublic": 1, "isfriend": 0, "isfamily": 0 },
        { "id": "31541154343", "owner": "135875088@N06", "secret": "2386ffbce5", "server": "494", "farm": 1, "title": "20170114-102326.jpg", "ispublic": 1, "isfriend": 0, "isfamily": 0 }
      ]
    }
    let(:urls_list) {
      [
        'https://farm1.staticflickr.com/497/32270508575_0677aaf835_b.jpg',
        'https://farm1.staticflickr.com/476/32230311666_a9dca67e83_b.jpg',
        'https://farm1.staticflickr.com/756/31893147470_5a84a074db_b.jpg'
      ]
    }

    before(:each) do
      FlickRaw.api_key = ENV['FLICKR_API_KEY']
      FlickRaw.shared_secret = ENV['FLICKR_SHARED_SECRET']
      stub_request(:post, "https://api.flickr.com/services/rest/").to_return(body: photos_list)
    end
  end
end
