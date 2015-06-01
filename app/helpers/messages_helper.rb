module MessagesHelper
  def publication_indicator(message)
    # fa_icon("flag", class: "publication-marker "+(message.published? ? 'published' : 'unpublished'),
    #  title: ( message.published? ? t('general.published') : t('general.unpublished')),
    #  data: {toggle: "tooltip"})
    fa_icon("flag", class: "publication-marker published", style: (message.published? ? 'display:inline' : 'display:none'),
      title: t('general.published'),
      data: {toggle: "tooltip"}) +
    fa_icon("flag", class: "publication-marker unpublished", style: (message.published? ? 'display:none' : 'display:inline'),
      title: t('general.unpublished'),
      data: {toggle: "tooltip"})
  end
end