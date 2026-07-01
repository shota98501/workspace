import React, { useEffect, useState } from "react";
import ReactMarkdown from "react-markdown";
import { Prism as SyntaxHighlighter } from "react-syntax-highlighter";

function NotebookPage({ slug }) {
  const [project, setProject] = useState(null);

  useEffect(() => {
    fetch(`http://localhost:8000/api/projects/${slug}/`)
      .then((res) => res.json())
      .then((data) => setProject(data));
  }, [slug]);

  if (!project) return <p>Loading...</p>;

  return (
    <div className="notebook-container">
      <h1>{project.title}</h1>
      <p>{project.description}</p>

      {project.cells.map((cell) => (
        <div key={cell.id} className="notebook-cell">
          {cell.cell_type === "markdown" && (
            <div className="markdown-cell">
              <ReactMarkdown>{cell.content}</ReactMarkdown>
            </div>
          )}

          {cell.cell_type === "code" && (
            <div className="code-cell">
              <SyntaxHighlighter language="python">
                {cell.content}
              </SyntaxHighlighter>
            </div>
          )}

          {cell.cell_type === "output" && (
            <pre className="output-cell">{cell.content}</pre>
          )}

          {cell.cell_type === "image" && (
            <img src={cell.image} alt="output" className="output-image" />
          )}

          {cell.cell_type === "table" && (
            <div
              className="table-cell"
              dangerouslySetInnerHTML={{ __html: cell.content }}
            />
          )}
        </div>
      ))}
    </div>
  );
}

export default NotebookPage;