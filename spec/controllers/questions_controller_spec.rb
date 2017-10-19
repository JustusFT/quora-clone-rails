require 'rails_helper'

RSpec.describe QuestionsController, type: :controller do
  describe "topic methods" do
    let!(:question) { create(:question) }
    let!(:topic) { create(:topic) }
    let!(:user) { create(:user) }

    describe "#search_topic" do
      describe "@results" do
        it "will return matching topics" do
          sign_in user
          get :search_topic, xhr: true, params: { id: question.id, q: topic.name[0] }
          expect(controller.instance_variable_get(:@results).include? topic).to be true
        end

        it "will not return matching topics already added to the question" do
          sign_in user
          question.topics << topic
          get :search_topic, xhr: true, params: { id: question.id, q: topic.name[0] }
          expect(controller.instance_variable_get(:@results).include? topic).to be false
        end
      end
    end

    describe "#add_topic" do
      it "can add a topic" do
        sign_in user
        expect {
          post :add_topic, params: { id: question.id, topic_id: topic.id }
        }.to change(question.topics, :count).by(1)
      end

      it "cannot add the same topic twice" do
        sign_in user
        post :add_topic, params: { id: question.id, topic_id: topic.id }
        expect {
          post :add_topic, params: { id: question.id, topic_id: topic.id }
        }.not_to change(question.topics, :count)
      end
    end

    describe "#remove_topic" do
      it "can remove a topic" do
        sign_in user
        post :add_topic, params: { id: question.id, topic_id: topic.id }
        expect {
          delete :remove_topic, params: { id: question.id, topic_id: topic.id }
        }.to change(question.topics, :count).by(-1)
      end
    end
  end

  describe "#create" do
    let!(:question) { build(:question) }
    let(:user) { question.user }

    context "when signed in" do
      before(:each) do
        sign_in user
      end

      it "can submit a valid question" do
        expect {
          post :create, params: { question: question.as_json }
        }.to change(Question, :count).by(1)
      end

      it "redirects to the created question upon submission" do
        post :create, params: { question: question.as_json }
        expect(response).to redirect_to(Question.last)
      end

      it "can not submit an invalid question" do
        expect {
          post :create, params: { question: attributes_for(:invalid_question) }
        }.not_to change(Question, :count)
      end
    end

    context "when signed out" do
      it "can not submit a question" do
        expect {
          post :create, params: { question: question.as_json }
        }.not_to change(Question, :count)
      end

      it "redirects to sign in page" do
        post :create, params: { question: question.as_json }
        expect(response).to redirect_to(new_user_session_url)
      end
    end
  end

  describe "#update" do
    let!(:question) { create(:question) }
    let(:user) { question.user }
    let(:new_attributes) { attributes_for(:question) }

    context "own questions" do
      it "can be updated" do
        sign_in user
        put :update, params: { id: question.id, question: new_attributes }
        question.reload

        new_attributes.each do |key, value|
          expect(question.attributes[key.to_s]).to eq(value)
        end
      end

      it "redirects to the question" do
        sign_in user
        put :update, params: { id: question.id, question: question.as_json }
        expect(response).to redirect_to(Question.last)
      end

      it "cannot update with invalid params" do
        sign_in user
        put :update, params: { id: question.id, question: attributes_for(:invalid_question) }
        question.reload

        new_attributes.each do |key, value|
          expect(question.attributes[key.to_s]).not_to eq(value)
        end
      end
    end

    context "other's questions" do
      it "cannot be updated" do
        sign_in create(:user)
        put :update, params: { id: question.id, question: new_attributes }
        question.reload

        new_attributes.each do |key, value|
          expect(question.attributes[key.to_s]).not_to eq(value)
        end
      end

      it "redirects to the question" do
        sign_in create(:user)
        put :update, params: { id: question.id, question: question.as_json }
        expect(response).to redirect_to(Question.last)
      end
    end
  end

  describe "#delete" do
    let!(:question) { create(:question) }
    let(:user) { question.user }

    context "own questions" do
      it "can delete a question" do
        sign_in user
        expect {
          delete :destroy, params: { id: question }
        }.to change(Question, :count).by(-1)
      end

      it "redirects to questions#index" do
        sign_in user
        delete :destroy, params: { id: question }
        expect(response).to redirect_to(questions_path)
      end
    end

    context "other's questions" do
      it "cannot delete" do
        sign_in create(:user)
        expect {
          delete :destroy, params: { id: question }
        }.not_to change(Question, :count)
      end

      it "redirects to question" do
        sign_in create(:user)
        delete :destroy, params: { id: question }
        expect(response).to redirect_to(Question.last)
      end
    end
  end
end
