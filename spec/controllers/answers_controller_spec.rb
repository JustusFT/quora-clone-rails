require 'rails_helper'

RSpec.describe AnswersController, type: :controller do
  describe "#create" do
    let!(:answer) { build(:answer) }
    let(:user) { answer.user }

    describe "signed in" do
      it "can create a question" do
        sign_in user
        expect {
          post :create, params: { answer: answer.as_json }
        }.to change(Answer, :count).by(1)
      end
    end

    describe "signed out" do
      it "cannot create a question" do
        expect {
          post :create, params: { answer: answer.as_json }
        }.not_to change(Answer, :count)
      end
    end

    it "redirects to the question" do
      sign_in user
      post :create, params: { answer: answer.as_json }
      expect(:response).to redirect_to(answer.question)
    end
  end

  describe "#update" do
    let!(:answer) { create(:answer) }
    let(:user) { answer.user }
    let(:new_attributes) { attributes_for(:answer) }

    describe "own answers" do
      it "can be updated" do
        sign_in user
        put :update, params: { id: answer, answer: new_attributes }
        answer.reload
        new_attributes.each do |key, value|
          expect(answer.attributes[key.to_s]).to eq(value)
        end
      end
    end

    describe "other's answers" do
      it "cannot be updated" do
        put :update, params: { id: answer, answer: new_attributes }
        answer.reload
        new_attributes.each do |key, value|
          expect(answer.attributes[key.to_s]).not_to eq(value)
        end
      end

      it "redirects to the question" do
        sign_in user
        put :update, params: { id: answer, answer: new_attributes }
        expect(response).to redirect_to(answer.question)
      end
    end

    describe "#destroy" do
      let!(:answer) { create(:answer) }
      let(:user) { answer.user }

      describe "own answers" do
        it "can be deleted" do
          sign_in user
          expect {
            delete :destroy, params: { id: answer }
          }.to change(Answer, :count).by(-1)
        end
      end

      describe "other's answers" do
        it "cannot be deleted" do
          other_user = create(:user)
          sign_in other_user
          expect {
            delete :destroy, params: { id: answer }
          }.not_to change(Answer, :count)
        end
      end

      it "redirects to the question" do
        sign_in user
        delete :destroy, params: { id: answer }
        expect(response).to redirect_to(answer.question)
      end
    end
  end
end
