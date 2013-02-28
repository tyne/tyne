(function($) {

  var Filter = Cell.create('Filter');

  Filter.prototype.initialize = function() {
    var _this = this;

    this.form = _this.$target.find("form");

    this.$target.on("click", "label", function(ev) {
      ev.preventDefault();

      var label = $(ev.target),
          filter = label.closest(".filter"),
          option = label.closest(".filter-options"),
          input = option.find("input"),
          link = option.find("a");

      filter.find(".icon-remove").removeClass("icon-remove").addClass("icon-plus");
      filter.find(":input").not(input).prop("checked", false);
      filter.find(".selected").removeClass("selected");
      input.prop("checked", true);

      option.addClass("selected");
      link.removeClass("icon-plus").addClass("icon-remove");

      _this.refresh();
    });

    this.$target.on("click", ".filter-add", function(ev) {
      ev.preventDefault();

      var target = $(ev.target),
          filter = target.closest(".filter"),
          filterOption = target.closest(".filter-options"),
          input = filterOption.find("input"),
          all = filter.find('[id*=_all]').closest(".filter-options"),
          selected = filterOption.is(".selected");

      if (selected) {
        // Remove filter
        input.prop("checked", false);
        target.removeClass("icon-remove").addClass("icon-plus");
        filterOption.removeClass("selected");

        // Select all if no filter is applied
        if (filter.find('input:checked').length == 0) {
          all.addClass("selected");
        }
      } else {
        // Add filter
        all.removeClass("selected");
        input.prop("checked", true);
        target.removeClass("icon-plus").addClass("icon-remove");
        filterOption.addClass("selected");
      };

      _this.refresh();
    });
  };

  Filter.prototype.resetState = function(data) {
    var _this = this,
        prefix = "filter",
        filter = _this.$target.find(".filter");

    // Set values
    filter.each(function(index, element) {
      var target = $(element),
          field = target.data('filter');

      target.find(".selected").removeClass("selected");
      target.find(".icon-remove").addClass("icon-plus");
      target.find(":checked").prop("checked", false);

      if (data.filter && data.filter[field]) {
        // Select entry
        var value = data.filter[field];

        $.each(value, function(innerIndex, innerElement) {
          var identifier = prefix + "_" + field + "_" + innerElement,
              element = target.find("#" + identifier);
          element.prop("checked", true);
          element.closest(".filter-options").addClass("selected");
          element.closest(".filter-options").find("a").removeClass("icon-plus").addClass("icon-remove");
        });
      } else {
        // Select all
        target.find('input[id*="_all"]').closest(".filter-options").addClass("selected");
      }
    });
  };

  Filter.prototype.refresh = function() {
    Search.instances[0].resetState();
    Backlog.instances[0].refresh(true);
  };

  Filter.prototype.options = function() {
    var _this = this;
        filter = _this.form.formParams()["filter"];
    for (var k in filter) {
      if (!filter[k]) delete filter[k];
    }

    return filter;
  };
})(jQuery);
