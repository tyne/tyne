$(function() {
  $('input.suggest').each(function(i) {
    var _this = $(this);
    var _hidden = _this.next();

    var options = {
      source: $(this).data('url'),
      minLength: 2,
      focus: function(event, ui) {
        _this.val(ui.item.label);
        return false;
      },
      select: function(event, ui) {
        _this.val(ui.item.label);
        _hidden.val(ui.item.value);
        return false;
      }
    };
    $(this).autocomplete(options).focus(function() {
      $(this).autocomplete("search", "");
    }).on("blur", function(event) {
      var autocomplete = $(this).data("autocomplete");
      var matcher = new RegExp("^" + $.ui.autocomplete.escapeRegex($(this).val()) + "$", "i");
      autocomplete.widget().children(".ui-menu-item").each(function() {
        var item = $(this).data("uiAutocompleteItem");
        if (matcher.test(item.label || item.value || item)) {
          autocomplete.selectedItem = item;
          return;
        }
      });

      if (autocomplete.selectedItem) {
        autocomplete._trigger("select", event, { item: autocomplete.selectedItem});
      } else {
        $(this).val('');
      }
    }).on("keydown", function(event) {
      if (event.which == 13) {
        $(this).blur();
        event.preventDefault();
        return false;
      }
    });
  });
});
