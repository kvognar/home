require 'spec_helper'

# Specs in this file have access to a helper object that includes
# the ApplicationHelper. For example:
#
# describe ApplicationHelper do
#   describe "string concat" do
#     it "concats two strings with spaces" do
#       expect(helper.concat_strings("this","that")).to eq("this that")
#     end
#   end
# end
describe ApplicationHelper, type: :helper do
  describe '#markdown' do
    it 'creates links with titles that open in a new tab' do
      expect(helper.markdown('[home](kevinvognar.com "welcome home")')).to eq "<p><a title=\"welcome home\" href=\"kevinvognar.com\" target=\"_blank\">home</a></p>\n"
    end
    it 'custom-embeds youtube links' do
      expect(helper.markdown('[[youtube]](ti2WZz0m2_s)')).to eq "<p><iframe class=\"youtube\" src=\"//www.youtube.com/embed/ti2WZz0m2_s?rel=0\" frameborder=\"0\" allowfullscreen></iframe></p>\n"
    end
  end
end
