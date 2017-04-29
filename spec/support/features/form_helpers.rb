module Features
  module FormHelpers
    def submit_form
      find('input[name="commit"]').click
    end

    def fill_in_trix_editor input
      script = "document.querySelector('trix-editor').editor.insertHTML(arguments[0])"
      Capybara.current_session.driver.browser.execute_script(script, input)
    end
  end
end
