require 'rails_helper'

# Specs in this file have access to a helper object that includes
# the KeywordFilesHelper. For example:
#
# describe KeywordFilesHelper do
#   describe "string concat" do
#     it "concats two strings with spaces" do
#       expect(helper.concat_strings("this","that")).to eq("this that")
#     end
#   end
# end
RSpec.describe ApplicationHelper, type: :helper do
  let(:focused_css) { "block py-2 pr-4 pl-3 font-semibold text-indigo-400 hover:text-indigo-300 rounded bg-primary-700 lg:bg-transparent lg:text-primary-700 lg:p-0 dark:text-white" }
  let(:unfocused_css) { "block py-2 pr-4 pl-3 text-gray-700 border-b border-gray-100 hover:bg-gray-50 lg:hover:bg-transparent lg:border-0 lg:hover:text-primary-700 lg:p-0 dark:text-gray-400 lg:dark:hover:text-white dark:hover:bg-gray-700 dark:hover:text-white lg:dark:hover:bg-transparent dark:border-gray-700 underline" }

  it "applies focus stylesheet to header item" do
    allow(helper).to receive(:params).and_return({ controller: "keywords", action: "index" })

    expect(helper.style_focused("keywords")).to eq(
      focused_css
    )

    expect(helper.style_focused("keyword_files")).to eq(
      unfocused_css
    )
  end
end
