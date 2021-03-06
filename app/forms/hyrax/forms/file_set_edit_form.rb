module Hyrax::Forms
  class FileSetEditForm
    include HydraEditor::Form
    include HydraEditor::Form::Permissions

    delegate :depositor, :permissions, to: :model

    self.required_fields = [:title, :creator, :keyword, :license]

    self.model_class = ::FileSet

    self.terms = [:resource_type, :title, :creator, :contributor, :description,
                  :keyword, :license, :publisher, :date_created, :subject, :language,
                  :identifier, :based_near, :related_url, :viewing_hint,
                  :visibility_during_embargo, :visibility_after_embargo, :embargo_release_date,
                  :visibility_during_lease, :visibility_after_lease, :lease_expiration_date,
                  :visibility]

    class_attribute :primary_fields
    self.primary_fields = []
    include ESSI::RemoteMetadataFormElements
  end
end
