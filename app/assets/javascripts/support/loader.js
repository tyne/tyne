(function($, undefined) {
  function Loader() {
  }

  Loader.load = function(from, $target, selector) {
    LoadingIndicator.addTo("body");
    var result;
    if (!selector) selector = '[role="dialog"]';

    var options = {
      async: false,
      success: function(data) {
        result = $target.append(data);
      }
    };

    $.ajax(from, options);

    LoadingIndicator.removeFrom("body");

    return result.find(selector).first();
  };

  ClassRegistry.set('Loader', Loader);
})(jQuery);

