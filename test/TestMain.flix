mod GraphViz.Test {
    use Graphviz.Model.Graph
    use Graphviz.Model.Strictness
    use Graphviz.Model.Statement
    use Graphviz.Model.Direction
    use Graphviz.Model.Endpoint
    use Graphviz.Compile.compile

    use Graphviz.Utils.TwoList

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

    @Test
    def test02(): Unit \ IO = {
        let g = Graph.Graph(
            Strictness.NonStrict,
            Direction.Directed,
            None, 
            List#{
                Statement.Node("Start", Nil),
                Statement.Node("End", Nil),
                Statement.Edge(TwoList.TwoList(Endpoint.Node("Start"), Endpoint.Node("End"), Nil), Nil)
            }
        );
        println(compile(g))
    }
}