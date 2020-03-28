class LinksController < ActionController::Base
  before_action :require_link, only: %i[show detail]

  def new
    @link = Link.new
  end

  def create
    url = params[:url]

    unless url_valid?(url)
      flash[:danger] = 'URL is not valid'

      return redirect_to action: :new
    end

    link = Link.create!(url: url, code: SecureRandom.alphanumeric(6))

    flash[:info] = 'New link created'

    redirect_to link_detail_path(link.code)
  end

  def show
    @link.update!(visits: @link.visits + 1)

    if @link.enabled
      redirect_to @link.url, status: :moved_permanently
    else
      redirect_to action: :new
    end
  end

  private

  def handle_unverified_request
    flash[:danger] = 'Form submission was not valid, please try again'

    redirect_to root_path
  end

  def url_valid?(url)
    url = URI.parse(url)

    url.is_a?(URI::HTTP) || url.is_a?(URI::HTTPS)
  rescue StandardException
    false
  end

  def require_link
    code = params[:link_id] || params[:id]

    @link = Link.find_by(code: code) if code.present?

    redirect_to root_path if @link.nil?
  end
end
