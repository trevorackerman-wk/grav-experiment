<?php
namespace Grav\Plugin;

class RemoteMarkdownTwigExtension extends \Twig_Extension
{
    public function getName()
    {
        return 'ExampleTwigExtension';
    }
    public function getFunctions()
    {
        return [
            new \Twig_SimpleFunction('example', [$this, 'exampleFunction'])
        ];
    }
    public function exampleFunction()
    {
        // create curl resource
        $ch = curl_init();

        // set url
        curl_setopt($ch, CURLOPT_URL, "https://raw.githubusercontent.com/trevorackerman/trailsy/master/README.md");

        //return the transfer as a string
        curl_setopt($ch, CURLOPT_RETURNTRANSFER, 1);

        // $output contains the output string
        $output = curl_exec($ch);

        // close curl resource to free up system resources
        curl_close($ch);

	include_once('/var/www/grav/vendor/erusev/parsedown/Parsedown.php');
	$pd = new \Parsedown();
	return $pd->text($output);
    }
}
