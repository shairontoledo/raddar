module Admin::AdminHelper
  def admin_page_title *args
    page_title [args.compact.join(' '), t('admin.page_title')].reject(&:blank?).compact.join(' - ')
  end
end
