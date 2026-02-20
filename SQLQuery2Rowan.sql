USE [Teralex]
GO

-- user
create table user (
    user_id        int            not null identity(1,1),
    username       nvarchar(100)  not null,
    email          nvarchar(255)  not null,
    password_hash  nvarchar(255)  not null,
    full_name      nvarchar(200)  null,
    phone          nvarchar(50)   null,
    office_name    nvarchar(200)  null,
    office_address nvarchar(500)  null,
    city           nvarchar(100)  null,
    created_at     datetime2      not null default getutcdate(),
    updated_at     datetime2      not null default getutcdate(),

    constraint pk_user primary key (user_id),
    constraint uq_user_username unique (username),
    constraint uq_user_email    unique (email)
);
go

-- template
create table template (
    template_id      int            not null identity(1,1),
    user_id          int            not null,
    template_type    nvarchar(100)  not null,
    template_name    nvarchar(200)  not null,
    template_content ntext          null,
    is_active        bit            not null default 1,
    is_special       bit            not null default 0,
    created_at       datetime2      not null default getutcdate(),
    updated_at       datetime2      not null default getutcdate(),

    constraint pk_template primary key (template_id),
    constraint fk_template_user
        foreign key (user_id) references user(user_id)
);
go

-- client
create table client (
    client_id          int            not null identity(1,1),
    user_id            int            not null,
    full_name          nvarchar(200)  not null,
    national_id        nvarchar(50)   null,
    phone              nvarchar(50)   null,
    email              nvarchar(255)  null,
    address            nvarchar(500)  null,
    client_type        nvarchar(100)  null,
    id_card_image_path nvarchar(500)  null,
    notes              ntext          null,
    created_at         datetime2      not null default getutcdate(),
    updated_at         datetime2      not null default getutcdate(),

    constraint pk_client primary key (client_id),
    constraint fk_client_user
        foreign key (user_id) references user(user_id)
);
go

-- workflow_stage
create table workflow_stage (
    stage_id           int            not null identity(1,1),
    template_id        int            null,
    stage_name         nvarchar(200)  not null,
    stage_type         nvarchar(100)  null,
    stage_order        int            not null default 0,
    milestone_days     int            null,
    description        ntext          null,
    required_documents ntext          null,
    checklist_items    ntext          null,
    is_transactional   bit            not null default 0,

    constraint pk_workflow_stage primary key (stage_id),
    constraint fk_workflow_stage_template
        foreign key (template_id) references template(template_id)
);
go