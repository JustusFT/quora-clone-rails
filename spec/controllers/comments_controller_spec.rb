require 'rails_helper'

RSpec.describe CommentsController, type: :controller do
  describe "#create" do
    let!(:comment) { build(:comment) }
    let(:user) { comment.user }

    describe "when signed in" do
      before(:each) do
        sign_in user
      end

      it "can comment on an answer" do
        expect {
          post :create, params: { comment: comment.as_json }
        }.to change(Comment, :count).by(1)
      end

      it "can comment on a comment" do
        parent_comment = create(:comment)
        expect {
          post :create, params: { comment: comment.as_json, parent_id: parent_comment.comment }
        }.to change(Comment, :count).by(1)
      end

      it "can comment on a comment on a comment" do
        parent_comment = create(:comment_reply)
        expect {
          post :create, params: { comment: comment.as_json, parent_id: parent_comment.comment }
        }.to change(Comment, :count).by(1)
      end
    end

    describe "when signed out" do
      it "can not comment on an answer" do
        expect {
          post :create, params: { comment: comment.as_json }
        }.not_to change(Comment, :count)
      end

      it "redirects to the sign in page" do
        post :create, params: { comment: comment.as_json }
        expect(response).to redirect_to(new_user_session_url)
      end
    end
  end

  describe "#update" do
    let!(:comment) { create(:comment) }
    let(:user) { comment.user }
    let(:new_attributes) { attributes_for(:comment) }

    describe "own comments" do
      it "can be updated" do
        sign_in user
        put :update, params: { id: comment, comment: new_attributes }
        comment.reload

        expect(comment.comment).to eq(new_attributes[:comment])
      end
    end

    describe "other's comments" do
      it "cannot be updated" do
        other_user = create(:user)
        sign_in other_user
        put :update, params: { id: comment, comment: new_attributes }
        comment.reload

        expect(comment.comment).not_to eq(new_attributes[:comment])
      end
    end
  end

  describe "#destroy" do
    let!(:comment) { create(:comment) }
    let(:user) { comment.user }

    describe "own comments" do
      it "will remove comment" do
        sign_in user
        expect {
          delete :destroy, params: { id: comment }
        }.to change(Comment, :count).by(-1)
      end
    end

    describe "other's comments" do
      it "can not be deleted" do
        other_user = create(:user)
        sign_in other_user
        expect {
          delete :destroy, params: { id: comment }
        }.not_to change(Comment, :count)
      end
    end
  end
end
