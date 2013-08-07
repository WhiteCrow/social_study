module SidebarHelper
  def breadcrumb_li(path, &block)
    content_tag :li, class: "#{'active' if request.path == path}" do
      link_to path do
        yield block if block
      end
    end
  end
end
