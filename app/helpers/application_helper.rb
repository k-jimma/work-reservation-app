module ApplicationHelper
  # 施設画像（未登録ならデフォルトURL）
  def room_image_tag(room, **opts)
    if room.respond_to?(:image) && room.image.attached?
      image_tag url_for(room.image), **opts
    else
      image_tag Rails.application.config.x.default_images[:room], **opts
    end
  end

  # アバター（未登録ならデフォルトURL）
  def avatar_image_tag(user, size: 32, **opts)
    if user.respond_to?(:avatar) && user.avatar.attached?
      image_tag url_for(user.avatar), { width: size, height: size }.merge(opts)
    else
      image_tag Rails.application.config.x.default_images[:avatar],
                { width: size, height: size }.merge(opts)
    end
  end
end

