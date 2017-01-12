class Dashboard::CardsController < Dashboard::BaseController
  require 'flickraw'

  before_action :set_card, only: [:destroy, :edit, :update]
  before_action :flickr_secrets, only: [:find_on_flickr]

  def index
    @cards = current_user.cards.all.order('review_date')
  end

  def new
    @card = Card.new
  end

  def edit
  end

  def create
    @card = current_user.cards.build(card_params)
    if @card.save
      redirect_to cards_path
    else
      render 'new'
    end
  end

  def update
    if @card.update(card_params)
      redirect_to cards_path
    else
      render 'edit'
    end
  end

  def destroy
    @card.destroy
    redirect_to cards_path
  end

  def find_on_flickr
    photos_list = flickr.photos.search tags: params[:flickr_tag], per_page: 10, format: 'json'
    respond_to do |format|
      format.html
      format.json do
        render json: {
          list: find_urls(photos_list),
        }
      end
    end
  end

  private

  def set_card
    @card = current_user.cards.find(params[:id])
  end

  def find_urls(list)
    urls = []
    list.each do |photo|
      urls << FlickRaw.url_m(flickr.photos.getInfo(photo_id: photo.id))
    end
    urls
  end

  def flickr_secrets
    FlickRaw.api_key = ENV['FLICKR_API_KEY']
    FlickRaw.shared_secret = ENV['FLICKR_SHARED_SECRET']
  end

  def card_params
    params.require(:card).permit(:original_text, :translated_text, :review_date,
                                 :image, :image_cache, :remote_image_url, :block_id)
  end
end
