
CREATE TYPE �ݾ�
	FROM CHAR(18) NULL
go



CREATE TABLE NewBook
( 
	bookid               integer  NOT NULL ,
	bookname             nvarchar(40)  NOT NULL ,
	price                integer  NULL ,
	pubname_FK_          nvarchar(40)  NOT NULL ,
	pubdate              datetime  NOT NULL 
)
go



ALTER TABLE NewBook
	ADD CONSTRAINT XPK���� PRIMARY KEY  CLUSTERED (bookid ASC)
go



CREATE TABLE NewCustomer
( 
	custid               integer  NOT NULL ,
	address              nvarchar(140)  NOT NULL ,
	name                 nvarchar(40)  NOT NULL ,
	phone                nvarchar(20)  NULL 
)
go



ALTER TABLE NewCustomer
	ADD CONSTRAINT XPK�� PRIMARY KEY  CLUSTERED (custid ASC)
go



CREATE TABLE NewOrder
( 
	bookid               integer  NOT NULL ,
	custid               integer  NOT NULL ,
	oderdate             datetime  NOT NULL ,
	saleprice            integer  NOT NULL ,
	orderid              integer  NOT NULL 
)
go



ALTER TABLE NewOrder
	ADD CONSTRAINT XPK�ֹ� PRIMARY KEY  CLUSTERED (orderid ASC)
go



CREATE TABLE NewPublisher
( 
	pubname              nvarchar(40)  NOT NULL ,
	stname               nvarchar(50)  NOT NULL ,
	officephone          varchar(20)  NULL 
)
go



ALTER TABLE NewPublisher
	ADD CONSTRAINT XPK���ǻ� PRIMARY KEY  CLUSTERED (pubname ASC)
go




ALTER TABLE NewBook
	ADD CONSTRAINT R_5 FOREIGN KEY (pubname_FK_) REFERENCES NewPublisher(pubname)
		ON DELETE NO ACTION
		ON UPDATE NO ACTION
go




ALTER TABLE NewOrder
	ADD CONSTRAINT R_6 FOREIGN KEY (bookid) REFERENCES NewBook(bookid)
		ON DELETE NO ACTION
		ON UPDATE NO ACTION
go




ALTER TABLE NewOrder
	ADD CONSTRAINT R_8 FOREIGN KEY (custid) REFERENCES NewCustomer(custid)
		ON DELETE NO ACTION
		ON UPDATE NO ACTION
go




CREATE TRIGGER tD_NewBook ON NewBook FOR DELETE AS
/* ERwin Builtin Trigger */
/* DELETE trigger on NewBook */
BEGIN
  DECLARE  @errno   int,
           @errmsg  varchar(255)
    /* ERwin Builtin Trigger */
    /* NewBook  NewOrder on parent delete no action */
    /* ERWIN_RELATION:CHECKSUM="00021464", PARENT_OWNER="", PARENT_TABLE="NewBook"
    CHILD_OWNER="", CHILD_TABLE="NewOrder"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_6", FK_COLUMNS="bookid" */
    IF EXISTS (
      SELECT * FROM deleted,NewOrder
      WHERE
        /*  %JoinFKPK(NewOrder,deleted," = "," AND") */
        NewOrder.bookid = deleted.bookid
    )
    BEGIN
      SELECT @errno  = 30001,
             @errmsg = 'Cannot delete NewBook because NewOrder exists.'
      GOTO ERROR
    END

    /* ERwin Builtin Trigger */
    /* NewPublisher  NewBook on child delete no action */
    /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="", PARENT_TABLE="NewPublisher"
    CHILD_OWNER="", CHILD_TABLE="NewBook"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_5", FK_COLUMNS="pubname_FK_" */
    IF EXISTS (SELECT * FROM deleted,NewPublisher
      WHERE
        /* %JoinFKPK(deleted,NewPublisher," = "," AND") */
        deleted.pubname_FK_ = NewPublisher.pubname AND
        NOT EXISTS (
          SELECT * FROM NewBook
          WHERE
            /* %JoinFKPK(NewBook,NewPublisher," = "," AND") */
            NewBook.pubname_FK_ = NewPublisher.pubname
        )
    )
    BEGIN
      SELECT @errno  = 30010,
             @errmsg = 'Cannot delete last NewBook because NewPublisher exists.'
      GOTO ERROR
    END


    /* ERwin Builtin Trigger */
    RETURN
ERROR:
    raiserror @errno @errmsg
    rollback transaction
END

go


CREATE TRIGGER tU_NewBook ON NewBook FOR UPDATE AS
/* ERwin Builtin Trigger */
/* UPDATE trigger on NewBook */
BEGIN
  DECLARE  @NUMROWS int,
           @nullcnt int,
           @validcnt int,
           @insbookid integer,
           @errno   int,
           @errmsg  varchar(255)

  SELECT @NUMROWS = @@rowcount
  /* ERwin Builtin Trigger */
  /* NewBook  NewOrder on parent update no action */
  /* ERWIN_RELATION:CHECKSUM="0002735a", PARENT_OWNER="", PARENT_TABLE="NewBook"
    CHILD_OWNER="", CHILD_TABLE="NewOrder"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_6", FK_COLUMNS="bookid" */
  IF
    /* %ParentPK(" OR",UPDATE) */
    UPDATE(bookid)
  BEGIN
    IF EXISTS (
      SELECT * FROM deleted,NewOrder
      WHERE
        /*  %JoinFKPK(NewOrder,deleted," = "," AND") */
        NewOrder.bookid = deleted.bookid
    )
    BEGIN
      SELECT @errno  = 30005,
             @errmsg = 'Cannot update NewBook because NewOrder exists.'
      GOTO ERROR
    END
  END

  /* ERwin Builtin Trigger */
  /* NewPublisher  NewBook on child update no action */
  /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="", PARENT_TABLE="NewPublisher"
    CHILD_OWNER="", CHILD_TABLE="NewBook"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_5", FK_COLUMNS="pubname_FK_" */
  IF
    /* %ChildFK(" OR",UPDATE) */
    UPDATE(pubname_FK_)
  BEGIN
    SELECT @nullcnt = 0
    SELECT @validcnt = count(*)
      FROM inserted,NewPublisher
        WHERE
          /* %JoinFKPK(inserted,NewPublisher) */
          inserted.pubname_FK_ = NewPublisher.pubname
    /* %NotnullFK(inserted," IS NULL","select @nullcnt = count(*) from inserted where"," AND") */
    select @nullcnt = count(*) from inserted where
      inserted.pubname_FK_ IS NULL
    IF @validcnt + @nullcnt != @NUMROWS
    BEGIN
      SELECT @errno  = 30007,
             @errmsg = 'Cannot update NewBook because NewPublisher does not exist.'
      GOTO ERROR
    END
  END


  /* ERwin Builtin Trigger */
  RETURN
ERROR:
    raiserror @errno @errmsg
    rollback transaction
END

go




CREATE TRIGGER tD_NewCustomer ON NewCustomer FOR DELETE AS
/* ERwin Builtin Trigger */
/* DELETE trigger on NewCustomer */
BEGIN
  DECLARE  @errno   int,
           @errmsg  varchar(255)
    /* ERwin Builtin Trigger */
    /* NewCustomer  NewOrder on parent delete no action */
    /* ERWIN_RELATION:CHECKSUM="0000f0cc", PARENT_OWNER="", PARENT_TABLE="NewCustomer"
    CHILD_OWNER="", CHILD_TABLE="NewOrder"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_8", FK_COLUMNS="custid" */
    IF EXISTS (
      SELECT * FROM deleted,NewOrder
      WHERE
        /*  %JoinFKPK(NewOrder,deleted," = "," AND") */
        NewOrder.custid = deleted.custid
    )
    BEGIN
      SELECT @errno  = 30001,
             @errmsg = 'Cannot delete NewCustomer because NewOrder exists.'
      GOTO ERROR
    END


    /* ERwin Builtin Trigger */
    RETURN
ERROR:
    raiserror @errno @errmsg
    rollback transaction
END

go


CREATE TRIGGER tU_NewCustomer ON NewCustomer FOR UPDATE AS
/* ERwin Builtin Trigger */
/* UPDATE trigger on NewCustomer */
BEGIN
  DECLARE  @NUMROWS int,
           @nullcnt int,
           @validcnt int,
           @inscustid integer,
           @errno   int,
           @errmsg  varchar(255)

  SELECT @NUMROWS = @@rowcount
  /* ERwin Builtin Trigger */
  /* NewCustomer  NewOrder on parent update no action */
  /* ERWIN_RELATION:CHECKSUM="00010a70", PARENT_OWNER="", PARENT_TABLE="NewCustomer"
    CHILD_OWNER="", CHILD_TABLE="NewOrder"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_8", FK_COLUMNS="custid" */
  IF
    /* %ParentPK(" OR",UPDATE) */
    UPDATE(custid)
  BEGIN
    IF EXISTS (
      SELECT * FROM deleted,NewOrder
      WHERE
        /*  %JoinFKPK(NewOrder,deleted," = "," AND") */
        NewOrder.custid = deleted.custid
    )
    BEGIN
      SELECT @errno  = 30005,
             @errmsg = 'Cannot update NewCustomer because NewOrder exists.'
      GOTO ERROR
    END
  END


  /* ERwin Builtin Trigger */
  RETURN
ERROR:
    raiserror @errno @errmsg
    rollback transaction
END

go




CREATE TRIGGER tD_NewOrder ON NewOrder FOR DELETE AS
/* ERwin Builtin Trigger */
/* DELETE trigger on NewOrder */
BEGIN
  DECLARE  @errno   int,
           @errmsg  varchar(255)
    /* ERwin Builtin Trigger */
    /* NewBook  NewOrder on child delete no action */
    /* ERWIN_RELATION:CHECKSUM="00024fc0", PARENT_OWNER="", PARENT_TABLE="NewBook"
    CHILD_OWNER="", CHILD_TABLE="NewOrder"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_6", FK_COLUMNS="bookid" */
    IF EXISTS (SELECT * FROM deleted,NewBook
      WHERE
        /* %JoinFKPK(deleted,NewBook," = "," AND") */
        deleted.bookid = NewBook.bookid AND
        NOT EXISTS (
          SELECT * FROM NewOrder
          WHERE
            /* %JoinFKPK(NewOrder,NewBook," = "," AND") */
            NewOrder.bookid = NewBook.bookid
        )
    )
    BEGIN
      SELECT @errno  = 30010,
             @errmsg = 'Cannot delete last NewOrder because NewBook exists.'
      GOTO ERROR
    END

    /* ERwin Builtin Trigger */
    /* NewCustomer  NewOrder on child delete no action */
    /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="", PARENT_TABLE="NewCustomer"
    CHILD_OWNER="", CHILD_TABLE="NewOrder"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_8", FK_COLUMNS="custid" */
    IF EXISTS (SELECT * FROM deleted,NewCustomer
      WHERE
        /* %JoinFKPK(deleted,NewCustomer," = "," AND") */
        deleted.custid = NewCustomer.custid AND
        NOT EXISTS (
          SELECT * FROM NewOrder
          WHERE
            /* %JoinFKPK(NewOrder,NewCustomer," = "," AND") */
            NewOrder.custid = NewCustomer.custid
        )
    )
    BEGIN
      SELECT @errno  = 30010,
             @errmsg = 'Cannot delete last NewOrder because NewCustomer exists.'
      GOTO ERROR
    END


    /* ERwin Builtin Trigger */
    RETURN
ERROR:
    raiserror @errno @errmsg
    rollback transaction
END

go


CREATE TRIGGER tU_NewOrder ON NewOrder FOR UPDATE AS
/* ERwin Builtin Trigger */
/* UPDATE trigger on NewOrder */
BEGIN
  DECLARE  @NUMROWS int,
           @nullcnt int,
           @validcnt int,
           @insorderid integer,
           @errno   int,
           @errmsg  varchar(255)

  SELECT @NUMROWS = @@rowcount
  /* ERwin Builtin Trigger */
  /* NewBook  NewOrder on child update no action */
  /* ERWIN_RELATION:CHECKSUM="00028bfd", PARENT_OWNER="", PARENT_TABLE="NewBook"
    CHILD_OWNER="", CHILD_TABLE="NewOrder"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_6", FK_COLUMNS="bookid" */
  IF
    /* %ChildFK(" OR",UPDATE) */
    UPDATE(bookid)
  BEGIN
    SELECT @nullcnt = 0
    SELECT @validcnt = count(*)
      FROM inserted,NewBook
        WHERE
          /* %JoinFKPK(inserted,NewBook) */
          inserted.bookid = NewBook.bookid
    /* %NotnullFK(inserted," IS NULL","select @nullcnt = count(*) from inserted where"," AND") */
    
    IF @validcnt + @nullcnt != @NUMROWS
    BEGIN
      SELECT @errno  = 30007,
             @errmsg = 'Cannot update NewOrder because NewBook does not exist.'
      GOTO ERROR
    END
  END

  /* ERwin Builtin Trigger */
  /* NewCustomer  NewOrder on child update no action */
  /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="", PARENT_TABLE="NewCustomer"
    CHILD_OWNER="", CHILD_TABLE="NewOrder"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_8", FK_COLUMNS="custid" */
  IF
    /* %ChildFK(" OR",UPDATE) */
    UPDATE(custid)
  BEGIN
    SELECT @nullcnt = 0
    SELECT @validcnt = count(*)
      FROM inserted,NewCustomer
        WHERE
          /* %JoinFKPK(inserted,NewCustomer) */
          inserted.custid = NewCustomer.custid
    /* %NotnullFK(inserted," IS NULL","select @nullcnt = count(*) from inserted where"," AND") */
    
    IF @validcnt + @nullcnt != @NUMROWS
    BEGIN
      SELECT @errno  = 30007,
             @errmsg = 'Cannot update NewOrder because NewCustomer does not exist.'
      GOTO ERROR
    END
  END


  /* ERwin Builtin Trigger */
  RETURN
ERROR:
    raiserror @errno @errmsg
    rollback transaction
END

go




CREATE TRIGGER tD_NewPublisher ON NewPublisher FOR DELETE AS
/* ERwin Builtin Trigger */
/* DELETE trigger on NewPublisher */
BEGIN
  DECLARE  @errno   int,
           @errmsg  varchar(255)
    /* ERwin Builtin Trigger */
    /* NewPublisher  NewBook on parent delete no action */
    /* ERWIN_RELATION:CHECKSUM="0000f021", PARENT_OWNER="", PARENT_TABLE="NewPublisher"
    CHILD_OWNER="", CHILD_TABLE="NewBook"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_5", FK_COLUMNS="pubname_FK_" */
    IF EXISTS (
      SELECT * FROM deleted,NewBook
      WHERE
        /*  %JoinFKPK(NewBook,deleted," = "," AND") */
        NewBook.pubname_FK_ = deleted.pubname
    )
    BEGIN
      SELECT @errno  = 30001,
             @errmsg = 'Cannot delete NewPublisher because NewBook exists.'
      GOTO ERROR
    END


    /* ERwin Builtin Trigger */
    RETURN
ERROR:
    raiserror @errno @errmsg
    rollback transaction
END

go


CREATE TRIGGER tU_NewPublisher ON NewPublisher FOR UPDATE AS
/* ERwin Builtin Trigger */
/* UPDATE trigger on NewPublisher */
BEGIN
  DECLARE  @NUMROWS int,
           @nullcnt int,
           @validcnt int,
           @inspubname nvarchar(40),
           @errno   int,
           @errmsg  varchar(255)

  SELECT @NUMROWS = @@rowcount
  /* ERwin Builtin Trigger */
  /* NewPublisher  NewBook on parent update no action */
  /* ERWIN_RELATION:CHECKSUM="00010e59", PARENT_OWNER="", PARENT_TABLE="NewPublisher"
    CHILD_OWNER="", CHILD_TABLE="NewBook"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_5", FK_COLUMNS="pubname_FK_" */
  IF
    /* %ParentPK(" OR",UPDATE) */
    UPDATE(pubname)
  BEGIN
    IF EXISTS (
      SELECT * FROM deleted,NewBook
      WHERE
        /*  %JoinFKPK(NewBook,deleted," = "," AND") */
        NewBook.pubname_FK_ = deleted.pubname
    )
    BEGIN
      SELECT @errno  = 30005,
             @errmsg = 'Cannot update NewPublisher because NewBook exists.'
      GOTO ERROR
    END
  END


  /* ERwin Builtin Trigger */
  RETURN
ERROR:
    raiserror @errno @errmsg
    rollback transaction
END

go


