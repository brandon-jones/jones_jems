require 'rails_helper'

RSpec.describe UsersController, :type => :controller do

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
    it "assigns all users as @users" do
      login_admin
      usr = FactoryGirl.create(:user, email: 'test2@test.com')
      get :index, {}
      expect(assigns(:user)).to eq([@user,usr])
    end

    it "renders index" do
      login_admin
      get :index
      expect(response).to render("index")
    end
  end

  describe "GET show" do
    it "renders the show view" do
      login_user
      get user_path(@user)
      expect(response).to render("show")
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
    describe "as admin" do
      before(:each) do
        login_admin
      end

      describe "with valid params" do

        it "updates the requested user" do
          faq = FactoryGirl.create(:user)
          put :update, {:id => user.to_param, :user => {email: 'new@test.com'}}
          user.reload
          expect(user.email).to eq('new@test.com')
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
  end

  describe "DELETE destroy" do
    describe "as admin" do
      before(:each) do
        login_admin
      end

      it "destroys the requested faq" do
        faq = FactoryGirl.create(:faq)
        expect {
          delete :destroy, {:id => faq.to_param}
        }.to change(Faq, :count).by(-1)
      end

      it "redirects to the users list" do
        user = FactoryGirl.create(:user)
        delete :destroy, {:id => user.to_param}
        expect(response).to redirect_to(users_url)
      end
    end

    describe "as user" do
      before(:each) do
        login_user
      end

      it "does not destroy the requested faq" do
        faq = FactoryGirl.create(:faq)
        expect {
          delete :destroy, {:id => faq.to_param}
        }.to change(Faq, :count).by(0)
      end

      it "redirects to the root path" do
        user = FactoryGirl.create(:user)
        delete :destroy, {:id => user.to_param}
        expect(response).to redirect_to(root_path)
      end
    end

  end

end
