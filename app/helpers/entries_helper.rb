module EntriesHelper
  def previous_entry_li(entry)
    content_tag :li, class: "entry-tab #{'active'if @entry == entry}" do
      link_to "#entry-#{entry.id}",
               id: "entry-tab-#{entry.id}",
               "data-link"=>"/entries/#{entry.id}",
               "data-toggle"=>"tab" do
        raw entry.title + " <i class='icon-remove'></i>"
      end
    end
  end
end
