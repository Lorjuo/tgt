module MessagesHelper
  def publication_indicator(message)
    fa_icon("flag", class: "publication-marker "+(message.published? ? 'published' : 'unpublished'),
      title: ( message.published? ? t('general.published') : t('general.unpublished')),
      data: {toggle: "tooltip"})
  end
end