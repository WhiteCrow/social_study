# coding: utf-8
require 'spec_helper'

describe "display notice", type: :feature do
  include Login

  let(:knowledge) { create :knowledge }

  it 'create note', js: true do
    knowledge
    visit "/notes/new?knowledge_id=#{knowledge.id}"
    fill_in 'note_title', with: 'note title'
    fill_in 'note_content', with: 'note content'
    click_button '提交'
    page.should have_selector('#message_container')
  end
end
