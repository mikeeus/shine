class AddEmailConstraintToUsers < ActiveRecord::Migration
  def up
    execute %{
      ALTER TABLE
        users
      ADD CONSTRAINT
        email_must_be_company_email
      CHECK ( email ~* '^[^@]+@shine\\.com' )
    }
  end

  def down
    execute %{
      ALTER TABLE
        users
      DROP CONSTRAINT
        email_must_be_company_mail
    }
  end
end
