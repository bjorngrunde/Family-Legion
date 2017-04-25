module Features
  module WaitForAjax

    def wait_for_ajax
      Timeout.timeout(Capybara.default_max_wait_time) do
        loop until finished_all_ajax_requests?
      end
    end

    def finished_all_ajax_requests?
      page.evaluate_script('jQuery.active').zero?
    end

    def page_reload
      page.evaluate_script("window.location.reload()")
    end

     def scroll_to(element)
      script = <<-JS
        arguments[0].scrollIntoView(true);
      JS

      Capybara.current_session.driver.browser.execute_script(script, element.native)
    end
  end
end
