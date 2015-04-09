require 'rails_helper'

# This spec was generated by rspec-rails when you ran the scaffold generator.
# It demonstrates how one might use RSpec to specify the controller code that
# was generated by Rails when you ran the scaffold generator.
#
# It assumes that the implementation code is generated by the rails scaffold
# generator.  If you are using any extension libraries to generate different
# controller code, this generated spec may or may not pass.
#
# It only uses APIs available in rails and/or rspec-rails.  There are a number
# of tools you can use to make these specs even more expressive, but we're
# sticking to rails and rspec-rails APIs to keep things simple and stable.
#
# Compared to earlier versions of this generator, there is very limited use of
# stubs and message expectations in this spec.  Stubs are only used when there
# is no simpler way to get a handle on the object needed for the example.
# Message expectations are only used when there is no simpler way to specify
# that an instance is receiving a specific message.

RSpec.describe FaqsController, :type => :controller do

  # This should return the minimal set of attributes required to create a valid
  # Faq. As you add validations to Faq, be sure to
  # adjust the attributes here as well.
  let(:valid_attributes) {
    { question: 'question', answer: 'answer' }
  }

  let(:invalid_attributes) {
    { question: '', answer: '' }
  }

  # This should return the minimal set of values that should be in the session
  # in order to pass any filters (e.g. authentication) defined in
  # FaqsController. Be sure to keep this updated too.

  describe "GET index" do
    it "assigns all faqs as @faqs" do
      faq = FactoryGirl.create(:faq)
      get :index, {}
      expect(assigns(:faqs)).to eq([faq])
    end
  end

  describe "GET show" do
    it "redirects to faqs for admins" do
      login_admin
      faq = FactoryGirl.create(:faq)
      get :show, {:id => faq.to_param}
      expect(assigns(:faq)).to redirect_to(faqs_path)
    end

    it "redirects to faqs for users" do
      login_user
      faq = FactoryGirl.create(:faq)
      get :show, {:id => faq.to_param}
      expect(assigns(:faq)).to redirect_to(root_path)
    end

    it "redirects to faqs for non logged in users" do
      faq = FactoryGirl.create(:faq)
      get :show, {:id => faq.to_param}
      expect(assigns(:faq)).to redirect_to(root_path)
    end
  end

  describe "GET new" do
    it "assigns a new faq as @faq to admin" do
      login_admin
      get :new, {}
      expect(assigns(:faq)).to be_a_new(Faq)
    end

    it "redirect to root for non admin" do
      login_user
      get :new, {}
      expect(assigns(:faq)).to redirect_to(root_path)
    end

    it "redirects to root for non logged in user" do
      get :new
      expect(assigns(:faq)).to redirect_to(root_path)
    end
  end

  describe "GET edit" do
    it "assigns the requested faq as @faq for admin" do
      login_admin
      faq = FactoryGirl.create(:faq)
      get :edit, {:id => faq.to_param}
      expect(assigns(:faq)).to eq(faq)
    end

    it "redirects to root for non admin user" do
      login_user
      faq = FactoryGirl.create(:faq)
      get :edit, {:id => faq.to_param}
      expect(assigns(:faq)).to redirect_to(root_path)
    end

    it "redirect to root for non logged in user" do
      faq = FactoryGirl.create(:faq)
      get :edit, {:id => faq.to_param}
      expect(assigns(:faq)).to redirect_to(root_path)
    end
  end

  describe "POST create" do

    describe "with valid params as admin" do
      before(:each) do
        login_admin
      end

      it "creates a new Faq" do
        expect {
          post :create, {:faq => valid_attributes}
        }.to change(Faq, :count).by(1)
      end

      it "assigns a newly created faq as @faq" do
        post :create, {:faq => valid_attributes}
        expect(assigns(:faq)).to be_a(Faq)
        expect(assigns(:faq)).to be_persisted
      end

      it "redirects to the created faq" do
        post :create, {:faq => valid_attributes}
        expect(response).to redirect_to(faqs_path)
      end
    end

    describe "with valid params as user" do
      before(:each) do
        login_user
      end

      it "does not create new FAQ" do
        expect {
          post :create, {:faq => valid_attributes}
        }.to change(Faq, :count).by(0)
      end

      it "does not assign a newly created faq as @faq" do
        post :create, {:faq => valid_attributes}
        expect(assigns(:faq)).to be_nil
        expect(assigns(:faq)).to redirect_to(root_path)
      end

      it "redirects to the root_path" do
        post :create, {:faq => valid_attributes}
        expect(response).to redirect_to(root_path)
      end
    end

    describe "with valid params not logged in" do
      it "does not create a new Faq" do
        expect {
          post :create, {:faq => valid_attributes}
        }.to change(Faq, :count).by(0)
      end

      it "does not assigns a newly created faq as @faq" do
        post :create, {:faq => valid_attributes}
        expect(assigns(:faq)).to be_nil
      end

      it "redirects to the created faq" do
        post :create, {:faq => valid_attributes}
        expect(response).to redirect_to(root_path)
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved faq as @faq" do
        post :create, {:faq => invalid_attributes}
        expect(assigns(:faq)).to be_nil
      end

      it "redirects to root path" do
        post :create, {:faq => invalid_attributes}
        expect(response).to redirect_to(root_path)
      end
    end
  end

  describe "PUT update" do
    before(:each) do
      login_admin
    end

    describe "with valid params" do
      let(:new_attributes) {
        {question: 'diff qusetion', answer: 'new answer'}
      }

      it "updates the requested faq" do
        faq = FactoryGirl.create(:faq)
        put :update, {:id => faq.to_param, :faq => new_attributes}
        faq.reload
        expect(faq.question).to eq(new_attributes[:question])
        expect(faq.answer).to eq(new_attributes[:answer])
      end

      it "assigns the requested faq as @faq" do
        faq = FactoryGirl.create(:faq)
        put :update, {:id => faq.to_param, :faq => valid_attributes}
        expect(assigns(:faq)).to eq(faq)
      end

      it "redirects to the faq" do
        faq = FactoryGirl.create(:faq)
        put :update, {:id => faq.to_param, :faq => valid_attributes}
        expect(response).to redirect_to(faqs_path)
      end
    end

    describe "with invalid params" do
      it "assigns the faq as @faq" do
        faq = FactoryGirl.create(:faq)
        put :update, {:id => faq.to_param, :faq => invalid_attributes}
        expect(assigns(:faq)).to eq(faq)
      end

      it "re-renders the 'edit' template" do
        faq = FactoryGirl.create(:faq)
        put :update, {:id => faq.to_param, :faq => invalid_attributes}
        expect(response).to render_template("edit")
      end
    end
  end

  describe "DELETE destroy" do
    before(:each) do
      login_admin
    end

    it "destroys the requested faq" do
      faq = FactoryGirl.create(:faq)
      expect {
        delete :destroy, {:id => faq.to_param}
      }.to change(Faq, :count).by(-1)
    end

    it "redirects to the faqs list" do
      faq = FactoryGirl.create(:faq)
      delete :destroy, {:id => faq.to_param}
      expect(response).to redirect_to(faqs_url)
    end
  end

end
