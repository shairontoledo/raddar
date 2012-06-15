module Admin::AdminHelper
  def admin_page_title *args
    page_title args.join(' ')+' - '+t('admin.page_title')
  end
end
