require 'spec_helper'

describe ProductsController do
  login_admin
  let(:valid_attributes) {attributes_for(:product)}
  it "has a valid factoryGirl" do
    build(:product).should be_valid
  end

  describe "GET index" do    
    it "should have a current_user" do
      subject.current_user.should_not be_nil
    end

    it "populates index with an array of products" do
      product = FactoryGirl.create(:product)
      get :index
      assigns(:products).should eq([product])
    end

    it "renders the index" do
      get :index
      response.should render_template :index
    end
  end

  describe "GET show" do
    it "asigna un producto a @product" do
      # product = Product.create! valid_attributes
      product = FactoryGirl.create(:product)
      get :show, id: product
      # product = assigns(:product)
      assigns(:product).should == product
    end
    it "renders the product show view" do
      product = FactoryGirl.create(:product)
      get :show, id: product
      response.should render_template :show
    end
  end

  describe "GET new" do
    it "assigns a new product to @product" do
      get :new
      @product = Product.new
    end
  end

  describe "GET edit" do
    it "assigns the requested product as @product" do
      product = FactoryGirl.create(:product)
      get :edit, id: product
      assigns(:product).should == product
      response.should be_success
    end
    it "renders the edit product view " do
      product = FactoryGirl.create(:product)
      get :edit, id: product
      response.should render_template :edit
    end
  end

  describe "POST create" do
    describe "with valid params" do
      it "creates a new product" do
        expect {
          post :create, product: FactoryGirl.attributes_for(:product)          
        }.to change(Product, :count).by(1)        
      end
      it "assigns a newly created product as @product" do
        post :create, {:product => valid_attributes}
        assigns(:product).should be_a(Product)
        assigns(:product).should be_persisted
      end

      it "redirects to the created product" do
        post :create, product: FactoryGirl.attributes_for(:product)
        response.should redirect_to(Product.last)
      end
    end
    describe "with invalid params" do
      it "assigns a newly created but unsaved product as @product" do
        # novalid = FactoryGirl.create(:invalid_product)
        # expect {
        #   post :create, product: FactoryGirl.attributes_for(novalid)
        # }.to_not change(Product, :count).by(1)  
        Product.any_instance.stub(:save).and_return(false)
        post :create, {:product => { "title" => "invalid value" }}
        assigns(:product).should be_a_new(Product)
      end
      it "re-renders the 'new' template" do
        Product.any_instance.stub(:save).and_return(false)
        post :create, {:product => { "title" => "invalid value" }}
        response.should render_template("new")
      end
    end
  end

  describe "PUT update" do
    before(:each) do
        @product = FactoryGirl.create(:product, title: 'Alalala')
    end
    context "con parametros validos" do
      it "encuentra el producto a editar" do
        put :update, id: @product, product: FactoryGirl.attributes_for(:product)
        assigns(:product).should eq(@product)
      end
      it "changes the title attribute of product" do
        put :update, id: @product, product: FactoryGirl.attributes_for(:product, title:'Alalalalong')
        @product.reload
        @product.title.should eq('Alalalalong')
      end
      it "redirects to the product url" do
        put :update, id: @product, product: FactoryGirl.attributes_for(:product)
        response.should redirect_to @product
      end
    end

    context "con parametros no validos" do
      it "encuentra el producto aasd no editar" do
        put :update, id: @product, product: FactoryGirl.attributes_for(:invalid_product)
        assigns(:product).should eq(@product)
      end
      it "no cambia el producto" do
        put :update, id: @product, product: FactoryGirl.attributes_for(:invalid_product, title: 'Shenlong',price: 0)
        @product.reload
        @product.title.should_not eq('Shenlong')
        @product.price.should_not eq(0)
      end

      it "assigns the product as @product" do
        product = Product.create! valid_attributes
        Product.any_instance.stub(:save).and_return(false)
        put :update, {:id => product.to_param, :product => { "title" => "invalid value" }}
        assigns(:product).should eq(product)
      end
      it "re-renders the 'edit' template" do
        product = Product.create! valid_attributes
        Product.any_instance.stub(:save).and_return(false)
        put :update, {:id => product.to_param, :product => { "title" => "invalid value" }}
        response.should render_template("edit")
      end
    end
  end

  describe "DELETE destroy" do
    before(:each) do
      @product = FactoryGirl.create(:product)
    end

    it "destroys the requested product" do
      expect {
        delete :destroy, id: @product
      }.to change(Product,:count).by(-1)
    end
    it "redirects to the products lists" do
      delete :destroy, id: @product
      response.should redirect_to products_url
    end
  end
end