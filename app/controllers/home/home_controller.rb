class Home::HomeController < Home::BaseController
  include IndexCards

  def index
    find_card
  end
end
