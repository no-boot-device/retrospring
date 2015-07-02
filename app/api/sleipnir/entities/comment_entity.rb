class Sleipnir::Entities::CommentEntity < Sleipnir::Entities::BaseEntity
  expose :id, format_with: :strid

  expose :content, as: :comment

  expose :smile_count, as: :smiles

  expose :answer_id

  expose :application, as: :created_with, with: Sleipnir::Entities::ApplicationReferenceEntity

  expose :created_at, format_with: :nanotime
end