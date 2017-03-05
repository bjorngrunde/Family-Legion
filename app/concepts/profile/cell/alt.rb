module Profile::Cell
  class Alt < Familylegion::Cell::Master

    def alt_css_class alt
      "#{alt.klass.sub("_", "-")}"
    end

    def name alt
      alt.name.humanize
    end
  end
end