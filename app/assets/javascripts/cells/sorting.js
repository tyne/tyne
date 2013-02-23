(function($) {

  var Sorting = Cell.create('Sorting');

  Sorting.prototype.initialize = function() {
    var _this = this;

    _this.form = _this.$target.find("form");
    _this.field = _this.$target.find('select[name*="field"]');
    _this.order = _this.$target.find('select[name*="order"]');

    _this.$target.on("change", ":input", function() {
      Backlog.instances[0].refresh(true);
    });
  };

  Sorting.prototype.resetState = function(data) {
    var _this = this;

    _this.form.populate({ sorting: data.sorting });
  };

  Sorting.prototype.options = function() {
    var _this = this;
    return _this.form.formParams()["sorting"];
  };
})(jQuery);
