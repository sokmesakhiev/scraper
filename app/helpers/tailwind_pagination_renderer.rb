require "will_paginate/view_helpers/action_view"

class TailwindPaginationRenderer < WillPaginate::ActionView::LinkRenderer
  def container_attributes
    { class: "flex justify-center space-x-1 mt-4 mb-4" }
  end

  def page_number(page)
    if page == current_page
      tag(:span, page, class: "px-3 py-1 bg-indigo-400 text-gray-200 rounded")
    else
      link(page, page, rel: rel_value(page), class: "px-3 py-1 bg-gray-500 border rounded hover:bg-gray-800")
    end
  end

  def previous_or_next_page(page, text, classname, aria_label = nil)
    if page
      link(text, page, class: "px-3 py-1 bg-gray-500 border rounded hover:bg-gray-800")
    else
      tag(:span, text, class: "px-3 py-1 bg-gray-200 border rounded text-gray-500 cursor-not-allowed")
    end
  end

  def html_container(html)
    tag(:nav, html, container_attributes)
  end
end
