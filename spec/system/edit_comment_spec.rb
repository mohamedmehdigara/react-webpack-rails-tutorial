require "rails_helper"
require "system/shared/examples"
require "system/shared/contexts"

feature "Edit a comment", existing_comment: true do
  let(:comment) { Comment.first }

  context "from classic page", page: :classic do
    background { click_link "Edit", match: :first }

    context "when edit is submitted" do
      let(:edited_name) { "Abraham Lincoln" }
      include_context "Form Submitted", name: :edited_name

      scenario "comment is updated" do
        expect(page).to have_css(".comment", text: :edited_name)
        expect(page).to have_css("#notice", text: "Comment was successfully updated.")
      end
    end

    context "when edit is submitted with blank fields", blank_form_submitted: true do
      scenario "comment is not updated" do
        expect(page).not_to have_success_message
        expect(page).to have_failure_message
        expect(page).not_to have_css(".comment", text: "")
      end
    end
  end
end

private

def have_success_message
  have_css("#notice", text: "Comment was successfully created.")
end

def have_failure_message
  have_css("#error_explanation")
end
