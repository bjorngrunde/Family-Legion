module Profile::Cell
  class Alt < Trailblazer::Cell

    def alt_css_class alt
      "#{alt.klass.sub("_", "-")}"
    end
  end
end