class Video < ApplicationRecord

  enum desejo: { quero_muito_muito_ver: 0, quero_muito_ver: 1, quero_ver: 2 }
  
  scope :nao_assistidos, -> { where(assistido: false) }
end
