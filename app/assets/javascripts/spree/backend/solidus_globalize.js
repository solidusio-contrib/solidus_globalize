(function() {
  var root;

  root = typeof exports !== "undefined" && exports !== null ? exports : this;

  root.taxon_tree_menu = function(obj, context) {
    var admin_base_url, edit_url, id, translation_base_path, translation_url;
    id = obj.attr("id");
    admin_base_url = Spree.path_for("admin/taxonomies/" + obj.data('taxonomy-id') + "/taxons");
    edit_url = admin_base_url.clone();
    edit_url.setPath(edit_url.path() + '/' + id + "/edit");
    translation_url = admin_base_url.clone();
    translation_base_path = admin_base_url.path().replace(/taxons/, "translations");
    translation_base_path = translation_base_path.replace(/taxonomies/, "taxons");
    translation_base_path = translation_base_path.replace(/\d+/, id);
    translation_url.setPath(translation_base_path);
    return {
      create: {
        label: "<span class='icon icon-plus'></span> " + Spree.translations.add,
        action: function(obj) {
          return context.create(obj);
        }
      },
      rename: {
        label: "<span class='icon icon-pencil'></span> " + Spree.translations.rename,
        action: function(obj) {
          return context.rename(obj);
        }
      },
      remove: {
        label: "<span class='icon icon-trash'></span> " + Spree.translations.remove,
        action: function(obj) {
          return context.remove(obj);
        }
      },
      edit: {
        separator_before: true,
        label: "<span class='icon icon-cog'></span> " + Spree.translations.edit,
        action: function(obj) {
          return window.location = edit_url.toString();
        }
      },
      translate: {
        separator_before: true,
        label: "<span class='icon icon-flag'></span> " + Spree.translations.translations,
        action: function(obj) {
          return window.location = translation_url.toString();
        }
      }
    };
  };

}).call(this);

(function() {
  var display_locale_fields;

  display_locale_fields = function() {
    var attr, display, locale, show, value;
    attr = $('#attr_list a.active').data('attr');
    locale = $('#locale').val();
    show = $("select[name='show-only']").val();
    $('#attr_fields .panel').hide();
    value = $('#attr_fields .panel.' + attr + '.' + locale + ' :input').val().replace(/^\s+|\s+$/g, "");
    if (show === 'incomplete') {
      display = value === '';
    } else if (show === 'complete') {
      display = value !== '';
    } else {
      display = true;
    }
    if (display) {
      $('#attr_fields .panel.' + attr + '.' + locale).show();
    }
    if ($('#attr_fields .panel:visible').length === 0 && show !== 'all') {
      return $('#attr_fields .no-translations').show();
    }
  };

  $(function() {
    $('#attr_list a').click(function() {
      $('#attr_list a').removeClass('active');
      $(this).addClass('active');
      display_locale_fields();
      return false;
    });
    $('#locale, #supported_locales_').select2({
      placeholder: Spree.translations['please_choose_language']
    });
    $('#locale').change(function() {
      return display_locale_fields();
    });
    $("select[name='show-only']").change(function() {
      return display_locale_fields();
    });
    if ($('#attr_list').is('*')) {
      return display_locale_fields();
    }
  });

}).call(this);
