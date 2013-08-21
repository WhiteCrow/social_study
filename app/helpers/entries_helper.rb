module EntriesHelper
  def previous_entry_li(entry)
    content_tag :li, class: "entry-tab #{'active'if @entry == entry}" do
      link_to "#entry-#{entry.id}",
               remote: true,
               id: "entry-tab-#{entry.id}",
               #"data-target"=>"/entries/#{entry.id}",
               "data-toggle"=>"tab" do
        raw entry.title + " <i class='icon-remove'></i>"
      end
    end
  end
end
