mod GraphViz.Test {
    use Graphviz.Model.Graph
    use Graphviz.Model.Strictness
    use Graphviz.Model.Statement
    use Graphviz.Model.Direction
    use Graphviz.Compile.compile

    @Test
    def test01(): Unit \ IO = {
        let g = Graph.Graph(
            Strictness.NonStrict,
            Direction.Undirected,
            Some("Foo"),
            Nil
        );
        println(compile(g))
    }

}