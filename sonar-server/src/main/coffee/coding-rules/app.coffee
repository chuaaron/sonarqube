requirejs.config
  baseUrl: "#{baseUrl}/js"

  paths:
    'backbone': 'third-party/backbone'
    'backbone.marionette': 'third-party/backbone.marionette'
    'handlebars': 'third-party/handlebars'
    'jquery.mockjax': 'third-party/jquery.mockjax'

  shim:
    'backbone.marionette':
      deps: ['backbone']
      exports: 'Marionette'
    'backbone':
      exports: 'Backbone'
    'handlebars':
      exports: 'Handlebars'


requirejs [
  'backbone', 'backbone.marionette',

  'coding-rules/layout',
  'coding-rules/router',

  # views
  'coding-rules/views/header-view',
  'coding-rules/views/actions-view',
  'coding-rules/views/filter-bar-view',
  'coding-rules/views/coding-rules-list-view',
  'coding-rules/views/coding-rules-detail-view',
  'coding-rules/views/coding-rules-bulk-change-view',
  'coding-rules/views/coding-rules-quality-profile-activation-view',
  'coding-rules/views/coding-rules-bulk-change-dropdown-view',
  'coding-rules/views/coding-rules-facets-view'

  # filters
  'navigator/filters/base-filters',
  'navigator/filters/choice-filters',
  'navigator/filters/string-filters',
  'navigator/filters/date-filter-view',
  'navigator/filters/read-only-filters',
  'coding-rules/views/filters/query-filter-view',
  'coding-rules/views/filters/quality-profile-filter-view',
  'coding-rules/views/filters/inheritance-filter-view',
  'coding-rules/views/filters/activation-filter-view',
  'coding-rules/views/filters/characteristic-filter-view',
  'coding-rules/views/filters/repository-filter-view',
  'coding-rules/views/filters/tag-filter-view',
  'coding-rules/views/filters/language-filter-view',

  'coding-rules/mockjax',
  'common/handlebars-extensions'
], (
  Backbone, Marionette,

  CodingRulesLayout,
  CodingRulesRouter,

  # views
  CodingRulesHeaderView,
  CodingRulesActionsView,
  CodingRulesFilterBarView,
  CodingRulesListView,
  CodingRulesDetailView,
  CodingRulesBulkChangeView,
  CodingRulesQualityProfileActivationView,
  CodingRulesBulkChangeDropdownView
  CodingRulesFacetsView

  # filters
  BaseFilters,
  ChoiceFilters,
  StringFilterView,
  DateFilterView,
  ReadOnlyFilterView,
  QueryFilterView,
  QualityProfileFilterView,
  InheritanceFilterView,
  ActivationFilterView,
  CharacteristicFilterView,
  RepositoryFilterView,
  TagFilterView,
  LanguageFilterView
) ->

  # Create a generic error handler for ajax requests
  jQuery.ajaxSetup
    error: (jqXHR) ->
      text = jqXHR.responseText
      errorBox = jQuery('.modal-error')
      if jqXHR.responseJSON?.errors?
        text = _.pluck(jqXHR.responseJSON.errors, 'msg').join '. '
      if errorBox.length > 0
        errorBox.show().text text
      else
        alert text


  # Add html class to mark the page as navigator page
  jQuery('html').addClass('navigator-page coding-rules-page');


  # Create an Application
  App = new Marionette.Application


  App.getQuery =  ->
    @filterBarView.getQuery()


  App.restoreSorting = (params) ->
#    sort = _.findWhere(params, key: 's')   || {'s': ''}
#    asc  = _.findWhere(params, key: 'asc') || {'asc': ''}
#    if @codingRules
#      @codingRules.sorting =
#        sort: sort.s
#        asc: asc.asc


  App.storeQuery = (query, sorting) ->
    if sorting && sorting.sort
      _.extend query,
        s: sorting.sort
        asc: '' + sorting.asc
    queryString = _.map query, (v, k) -> "#{k}=#{encodeURIComponent(v)}"
    @router.navigate queryString.join('|'), replace: true



  App.fetchList = (firstPage, fromFacets) ->
    query = @getQuery()
    fetchQuery = _.extend { p: @pageIndex, ps: 25, facets: !fromFacets }, query

    if @codingRulesFacetsView
      _.extend fetchQuery, @codingRulesFacetsView.getQuery()

    if @codingRules.sorting && @codingRules.sorting.sort
      _.extend fetchQuery,
          s: @codingRules.sorting.sort,
          asc: @codingRules.sorting.asc

    @storeQuery query, @codingRules.sorting

    # Optimize requested fields
    _.extend fetchQuery, f: 'name,lang,status'

    if @codingRulesListView
      scrollOffset = jQuery('.navigator-results')[0].scrollTop
    else
      scrollOffset = 0

    if firstPage
      @layout.showSpinner 'resultsRegion'
    #else
    #  @layout.showSpinner 'resultsRegion'
    @layout.showSpinner 'facetsRegion' unless fromFacets || !firstPage
    jQuery.ajax
      url: "#{baseUrl}/api/rules/search"
      data: fetchQuery
    .done (r) =>
      _.map(r.rules, (rule) ->
        rule.language = App.languages[rule.lang]
      )

      @codingRules.paging =
        total: r.total
        pageIndex: r.p
        pageSize: r.ps
        pages: 1 + (r.total / r.ps)
      if firstPage
        @codingRules.reset r.rules
        @codingRulesListView = new CodingRulesListView
          app: @
          collection: @codingRules
        @layout.resultsRegion.show @codingRulesListView
      else
        @codingRulesListView.unbindEvents()
        @codingRules.add r.rules
        @codingRulesListView.render()

      if @codingRules.isEmpty()
        @layout.detailsRegion.reset()
      else if firstPage
        @codingRulesListView.selectFirst()
      else
        @codingRulesListView.selectCurrent()

      unless firstPage
        jQuery('.navigator-results')[0].scrollTop = scrollOffset

      unless fromFacets
        @codingRulesFacetsView = new CodingRulesFacetsView
          app: @
          collection: new Backbone.Collection r.facets, comparator: 'property'
        @layout.facetsRegion.show @codingRulesFacetsView

      @layout.onResize()



  App.facetLabel = (property, value) ->
    return value unless App.facetPropertyToLabels[property]
    App.facetPropertyToLabels[property](value)


  App.fetchFirstPage = (fromFacets = false) ->
    @pageIndex = 1
    App.fetchList true, fromFacets


  App.fetchNextPage = (fromFacets = false) ->
    if @pageIndex < @codingRules.paging.pages
      @pageIndex++
      App.fetchList false, fromFacets


  App.getQualityProfile = ->
    value = @qualityProfileFilter.get('value')
    if value? && value.length == 1 then value[0] else null


  App.getQualityProfilesForLanguage = (language_key) ->
    _.filter App.qualityProfiles, (p) => p.lang == language_key

  App.getQualityProfileByKey = (profile_key) ->
    _.findWhere App.qualityProfiles, key: profile_key

  App.showRule = (ruleKey) ->
    App.layout.showSpinner 'detailsRegion'
    jQuery.ajax
      url: "#{baseUrl}/api/rules/show"
      data:
        key: ruleKey
        actives: true
    .done (r) =>
      rule = new Backbone.Model(r.rule)
      App.codingRulesQualityProfileActivationView.rule = rule
      App.detailView = new CodingRulesDetailView
        app: App
        model: rule
        actives: r.actives
      App.layout.detailsRegion.show App.detailView


  # Construct layout
  App.addInitializer ->
    @layout = new CodingRulesLayout app: @
    jQuery('#content').append @layout.render().el
    @layout.onResize()


  # Construct header
  App.addInitializer ->
    @codingRulesHeaderView = new CodingRulesHeaderView app: @
    @layout.headerRegion.show @codingRulesHeaderView


  # Define coding rules
  App.addInitializer ->
    @codingRules = new Backbone.Collection
    @codingRules.sorting = sort: '', asc: ''


  # Construct status bar
  App.addInitializer ->
    @codingRulesActionsView = new CodingRulesActionsView
      app: @
      collection: @codingRules
    @layout.actionsRegion.show @codingRulesActionsView


  # Construct bulk change views
  App.addInitializer ->
    @codingRulesBulkChangeView = new CodingRulesBulkChangeView app: @
    @codingRulesBulkChangeDropdownView = new CodingRulesBulkChangeDropdownView app: @


  # Construct quality profile activation view
  App.addInitializer ->
    @codingRulesQualityProfileActivationView = new CodingRulesQualityProfileActivationView app: @


  # Define filters
  App.addInitializer ->
    @filters = new BaseFilters.Filters

    @queryFilter = new BaseFilters.Filter
      property: 'q'
      type: QueryFilterView
      size: 50
    @filters.add @queryFilter

    @filters.add new BaseFilters.Filter
      name: t 'coding_rules.filters.severity'
      property: 'severities'
      type: ChoiceFilters.ChoiceFilterView
      optional: true
      choices:
        'BLOCKER': t 'severity.BLOCKER'
        'CRITICAL': t 'severity.CRITICAL'
        'MAJOR': t 'severity.MAJOR'
        'MINOR': t 'severity.MINOR'
        'INFO': t 'severity.INFO'
      choiceIcons:
        'BLOCKER': 'severity-blocker'
        'CRITICAL': 'severity-critical'
        'MAJOR': 'severity-major'
        'MINOR': 'severity-minor'
        'INFO': 'severity-info'

    @filters.add new BaseFilters.Filter
      name: t 'coding_rules.filters.tag'
      property: 'tags'
      type: TagFilterView
      optional: true

    @filters.add new BaseFilters.Filter
      name: t 'coding_rules.filters.characteristic'
      property: 'debt_characteristics'
      type: CharacteristicFilterView
      choices: @characteristics
      multiple: false
      optional: true

    @qualityProfileFilter = new BaseFilters.Filter
      name: t 'coding_rules.filters.quality_profile'
      property: 'qprofile'
      type: QualityProfileFilterView
      app: @
      choices: @qualityProfiles
      multiple: false
    @filters.add @qualityProfileFilter

    @activationFilter = new BaseFilters.Filter
      name: t 'coding_rules.filters.activation'
      property: 'activation'
      type: ActivationFilterView
      enabled: false
      optional: true
      multiple: false
      qualityProfileFilter: @qualityProfileFilter
      choices:
        true: t 'coding_rules.filters.activation.active'
        false: t 'coding_rules.filters.activation.inactive'
    @filters.add @activationFilter

    @languageFilter =  new BaseFilters.Filter
      name: t 'coding_rules.filters.language'
      property: 'languages'
      type: LanguageFilterView
      app: @
      choices: @languages
      optional: true
    @filters.add @languageFilter

    @filters.add new BaseFilters.Filter
      name: t 'coding_rules.filters.availableSince'
      property: 'available_since'
      type: DateFilterView
      enabled: false
      optional: true

    @filters.add new BaseFilters.Filter
      name: t 'coding_rules.filters.inheritance'
      property: 'inheritance'
      type: InheritanceFilterView
      enabled: false
      optional: true
      multiple: false
      qualityProfileFilter: @qualityProfileFilter
      choices:
        'NONE': t 'coding_rules.filters.inheritance.not_inherited'
        'INHERITED': t 'coding_rules.filters.inheritance.inherited'
        'OVERRIDES': t 'coding_rules.filters.inheritance.overriden'

    @filters.add new BaseFilters.Filter
      name: t 'coding_rules.filters.repository'
      property: 'repositories'
      type: RepositoryFilterView
      enabled: false
      optional: true
      app: @
      choices: @repositories

    @filters.add new BaseFilters.Filter
      name: t 'coding_rules.filters.status'
      property: 'statuses'
      type: ChoiceFilters.ChoiceFilterView
      enabled: false
      optional: true
      choices: @statuses

    @filters.add new BaseFilters.Filter
      name: t 'coding_rules.filters.template'
      property: 'is_template'
      type: ChoiceFilters.ChoiceFilterView
      optional: true
      multiple: false
      choices:
        'true': t 'coding_rules.filters.template.is_template'
        'false': t 'coding_rules.filters.template.is_not_template'

    @filters.add new BaseFilters.Filter
      name: t 'coding_rules.filters.key'
      property: 'rule_key'
      type: ReadOnlyFilterView
      enabled: false
      inactive: true
      optional: true


    @filterBarView = new CodingRulesFilterBarView
      app: @
      collection: @filters,
      extra: sort: '', asc: false
    @layout.filtersRegion.show @filterBarView


  # Start router
  App.addInitializer ->
    @router = new CodingRulesRouter app: @
    Backbone.history.start()


  # Call app before start the application
  appXHR = jQuery.ajax
    url: "#{baseUrl}/api/rules/app"
  .done (r) ->
    App.appState = new Backbone.Model
    App.state = new Backbone.Model
    App.canWrite = r.canWrite
    App.qualityProfiles = _.sortBy r.qualityprofiles, ['name', 'lang']
    App.languages = _.extend r.languages, none: 'None'
    App.repositories = r.repositories
    App.repositories.push
      key: 'manual'
      name: 'Manual Rules'
      language: 'none'
    App.statuses = r.statuses
    App.characteristics = r.characteristics

    App.facetPropertyToLabels =
      'languages': (value) -> App.languages[value]
      'repositories': (value) ->
        repo = _.findWhere(App.repositories, key: value)
        other_repo_with_same_name = _.find(App.repositories, (repos) -> repos.name == repo.name && repos.key != repo.key)
        if other_repo_with_same_name
          repo.name + ' - ' + App.languages[repo.language]
        else
          repo.name

  # Message bundles
  l10nXHR = window.requestMessages()

  jQuery.when(appXHR, l10nXHR).done ->
      # Remove the initial spinner
      jQuery('#coding-rules-page-loader').remove()

      # Start the application
      App.start()
