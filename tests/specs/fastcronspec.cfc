component extends="testbox.system.BaseSpec" {

  function beforeAll() {
		variables.apiKey = "";
  }

  // executes after all suites
  function afterAll() {

  }

  // All suites go in here
  function run( testResults, testBox ) {
    describe( "fastcron.cfc", function() {
      beforeEach( function( currentSpec ) {
				variables.fastCron = new fastcron( apiKey = variables.apiKey, debug = true );
      } );
      afterEach( function( currentSpec ) {
				structDelete( variables, "fastCron" );
      } );
      
      describe( "account", function() {
        it( "should return account", function() {
          var out = variables.fastCron.accountGet();
          debug( out );
          expect( out ).toBeStruct();
          expect( out.success ).toBeTrue();
        } );
      } );

      describe( "jobs", function() {
        it( "should create a new cron job", function() {
          var out = variables.fastCron.jobAdd(
            name = "fastcron-test",
            url = "https://www.google.com",
            expression = "12 hours"
          );
          debug( out );
          expect( out ).toBeStruct();
          expect( out.success ).toBeTrue();
          expect( out.response.data.id ?: '' ).toBeNumeric();
        });

        it( "should list jobs", function() {
          var out = variables.fastCron.jobList();
          debug( out );
          expect( out ).toBeStruct();
          expect( out.success ).toBeTrue();
          expect( out.response ).toBeStruct();
          expect( out.response.data ).toBeArray();
          expect( arrayLen( out.response.data ) ).toBeGTE( 1 );
        });

        it( "should edit a job", function() {
          var out = variables.fastCron.jobEdit(
            idOrName = "fastcron-test",
            url = "https://www.google.com",
            expression = "1 hours"
          );
          debug( out );
          expect( out ).toBeStruct();
          expect( out.success ).toBeTrue();
        });

        it( "should disable a job", function() {
          var out = variables.fastCron.jobDisable( "fastcron-test" );
          debug( out );
          expect( out ).toBeStruct();
          expect( out.success ).toBeTrue();
        });

        it( "should enable a job", function() {
          var out = variables.fastCron.jobEnable( "fastcron-test" );
          debug( out );
          expect( out ).toBeStruct();
          expect( out.success ).toBeTrue();
        });

        it( "should run a job", function() {
          var out = variables.fastCron.jobRun( "fastcron-test" );
          debug( out );
          expect( out ).toBeStruct();
          expect( out.success ).toBeTrue();
        });

        it( "should say when job runs next", function() {
          var out = variables.fastCron.jobNext( "fastcron-test" );
          debug( out );
          expect( out ).toBeStruct();
          expect( out.success ).toBeTrue();
        });

        it( "should list job logs", function() {
          var out = variables.fastCron.jobLogs( "fastcron-test" );
          debug( out );
          expect( out ).toBeStruct();
          expect( out.success ).toBeTrue();
        });

        it( "should delete a job", function() {
          var out = variables.fastCron.jobDelete( "fastcron-test" );
          debug( out );
          expect( out ).toBeStruct();
          expect( out.success ).toBeTrue();
        } );
      } );


      describe( "groups", function() {
        it( "should create a new group", function() {
          var out = variables.fastCron.groupAdd( "fastcron-test" );
          debug( out );
          expect( out ).toBeStruct();
          expect( out.success ).toBeTrue();
          expect( out.response.data.id ?: '' ).toBeNumeric();
        });

        it( "should list groups", function() {
          var out = variables.fastCron.groupList();
          debug( out );
          expect( out ).toBeStruct();
          expect( out.success ).toBeTrue();
          expect( out.response ).toBeStruct();
          expect( out.response.data ).toBeArray();
          expect( arrayLen( out.response.data ) ).toBeGTE( 1 );
        });

        it( "should add job to group", function() {
          var out = variables.fastCron.jobAdd(
            name = "fastcron-test",
            url = "https://www.google.com",
            expression = "12 hours",
            group = "fastcron-test"
          );
          debug( out );
          expect( out ).toBeStruct();
          expect( out.success ).toBeTrue();
        });

        it( "should list jobs in group", function() {
          var out = variables.fastCron.groupItems( "fastcron-test" );
          debug( out );
          expect( out ).toBeStruct();
          expect( out.success ).toBeTrue();
          expect( out.response ).toBeStruct();
          expect( out.response.data ).toBeArray();
          expect( arrayLen( out.response.data ) ).toBe( 1 );
        });

        it( "should remove jobs from group", function() {
          var out = variables.fastCron.groupEmpty( "fastcron-test" );
          debug( out );
          expect( out ).toBeStruct();
          expect( out.success ).toBeTrue();

          var out = variables.fastCron.groupItems( "fastcron-test" );
          debug( out );
          expect( out ).toBeStruct();
          expect( out.success ).toBeTrue();
          expect( out.response ).toBeStruct();
          expect( out.response.data ).toBeArray();
          expect( arrayLen( out.response.data ) ).toBe( 0 );
        });

        it( "should remove group", function() {
          var out = variables.fastCron.groupDelete( "fastcron-test" );
          debug( out );
          expect( out ).toBeStruct();
          expect( out.success ).toBeTrue();
        });
        
      });


    } );
  }
}
