class PurchasesController < ApplicationController
  before_action :authenticate_user!, except: [:notification, :abandoned]
  before_action :set_product, only: [:new, :create]
  before_action :set_purchase, only: [:show, :update, :destroy]

  # Ignorar validação contra ataque CSRF, pois o pagseguro não envia a token
  skip_before_action :verify_authenticity_token 

  # GET /purchases
  # GET /purchases.json
  def index
    @purchases = current_user.purchases
  end

  # GET /purchases/1
  # GET /purchases/1.json
  def show
    raise Http404 if @purchase.user != current_user
  end

  # GET /purchases/new
  def new
    @purchase = Purchase.new(product: @product)
  end

  # POST /purchases/abandoned
  def abandoned
    Rails.logger.info %Q(
      Requisição recebida de compra abandonada: 
        [notificationCode: #{params[:notificationCode]}] 
      )
    response = PagSeguroService.notification_info(params[:notificationCode])

    purchase = Purchase.find_by token: response.token
    purchase.status = response.status
    purchase.save
    Rails.logger.info "Compra abandonada: #{purchase.product.name} - #{response.transaction.reference}"
    render :nothing => true, :status => 200, :content_type => 'text/html'    
  end

  # POST /purchases/notification
  def notification
    Rails.logger.info %Q(
      Requisição recebida de compra concluída: 
        [notificationCode: #{params[:notificationCode]}] 
      )
    
    response = PagSeguroService.notification_info(params[:notificationCode])
    purchase = Purchase.find_by token: response.token
    purchase.status = response.status
    purchase.save
    Rails.logger.info "Compra efetuada: #{purchase.product.name} - #{purchase.token}"
    render :nothing => true, :status => 200, :content_type => 'text/html'
  end

  # POST /purchases
  # POST /purchases.json
  def create
    @purchase = Purchase.new(product: @product, user: current_user)
    @purchase.token = SecureRandom.hex
    
    urls = {
      :abandoned => abandoned_purchases_url,
      :notification => notification_purchases_url,
      :redirect => purchases_url
    }

    puts "urls", urls

    if @purchase.save
      response = PagSeguroService.create_payment_request(@purchase, current_user, urls)
      if response.errors.empty?
        redirect_to response.url
      else
        render :new, notice: response.errors.join("\n")
      end
    else
      render :new
    end
  end

  # PATCH/PUT /purchases/1
  # PATCH/PUT /purchases/1.json
  def update
    respond_to do |format|
      if @purchase.update(purchase_params)
        format.html { redirect_to @purchase, notice: 'Purchase was successfully updated.' }
        format.json { render :show, status: :ok, location: @purchase }
      else
        format.html { render :edit }
        format.json { render json: @purchase.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /purchases/1
  # DELETE /purchases/1.json
  def destroy
    @purchase.destroy
    respond_to do |format|
      format.html { redirect_to purchases_url, notice: 'Purchase was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_product
      @product = Product.find_by(slug: params[:product_id]) || Product.find(params[:product_id])
    end

    # Use callbacks to share common setup or constraints between actions.
    def set_purchase
      @purchase = Purchase.find(params[:id])
    end
end
