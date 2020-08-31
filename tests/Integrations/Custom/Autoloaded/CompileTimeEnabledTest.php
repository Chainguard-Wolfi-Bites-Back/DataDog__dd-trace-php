<?php

namespace DDTrace\Tests\Integrations\Custom\Autoloaded;

use DDTrace\Tests\Common\WebFrameworkTestCase;
use DDTrace\Tests\Frameworks\Util\Request\GetSpec;

final class CompileTimeEnabledTest extends WebFrameworkTestCase
{
    protected static function getAppIndexScript()
    {
        return __DIR__ . '/../../../Frameworks/Custom/Version_Autoloaded/public/index.php';
    }

    protected static function getEnvs()
    {
        return array_merge(parent::getEnvs(), [
            'DD_TRACE_MEASURE_COMPILE_TIME' => '1',
        ]);
    }

    protected function setUp()
    {
        parent::setUp();
        /* The span encoder of this process gets used to convert the trace's spans into an array.
         * For the compile-time metrics specifically, this goofs things up, so let's disable.
         */
        \putenv('DD_TRACE_MEASURE_COMPILE_TIME=0');
        \dd_trace_internal_fn('ddtrace_reload_config');
    }

    protected function tearDown()
    {
        \putenv('DD_TRACE_MEASURE_COMPILE_TIME');
        dd_trace_internal_fn('ddtrace_reload_config');
        parent::tearDown();
    }

    public function testScenario()
    {
        $traces = $this->tracesFromWebRequest(function () {
            $spec = GetSpec::create('Compile time exists on root span', '/simple');
            $this->call($spec);
        });

        self::assertTrue(isset($traces[0][0]['metrics']['php.compilation.total_time_ms']));
    }
}
