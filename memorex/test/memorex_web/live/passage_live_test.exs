defmodule MemorexWeb.PassageLiveTest do
  use MemorexWeb.ConnCase

  import Phoenix.LiveViewTest

  alias Memorex.Library

  @create_attrs %{phrase: "some phrase", slug: "some slug", steps: 42}
  @update_attrs %{phrase: "some updated phrase", slug: "some updated slug", steps: 43}
  @invalid_attrs %{phrase: nil, slug: nil, steps: nil}

  defp fixture(:passage) do
    {:ok, passage} = Library.create_passage(@create_attrs)
    passage
  end

  defp create_passage(_) do
    passage = fixture(:passage)
    %{passage: passage}
  end

  describe "Index" do
    setup [:create_passage]

    test "lists all passages", %{conn: conn, passage: passage} do
      {:ok, _index_live, html} = live(conn, Routes.passage_index_path(conn, :index))

      assert html =~ "Listing Passages"
      assert html =~ passage.phrase
    end

    test "saves new passage", %{conn: conn} do
      {:ok, index_live, _html} = live(conn, Routes.passage_index_path(conn, :index))

      assert index_live |> element("a", "New Passage") |> render_click() =~
               "New Passage"

      assert_patch(index_live, Routes.passage_index_path(conn, :new))

      assert index_live
             |> form("#passage-form", passage: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      {:ok, _, html} =
        index_live
        |> form("#passage-form", passage: @create_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.passage_index_path(conn, :index))

      assert html =~ "Passage created successfully"
      assert html =~ "some phrase"
    end

    test "updates passage in listing", %{conn: conn, passage: passage} do
      {:ok, index_live, _html} = live(conn, Routes.passage_index_path(conn, :index))

      assert index_live |> element("#passage-#{passage.id} a", "Edit") |> render_click() =~
               "Edit Passage"

      assert_patch(index_live, Routes.passage_index_path(conn, :edit, passage))

      assert index_live
             |> form("#passage-form", passage: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      {:ok, _, html} =
        index_live
        |> form("#passage-form", passage: @update_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.passage_index_path(conn, :index))

      assert html =~ "Passage updated successfully"
      assert html =~ "some updated phrase"
    end

    test "deletes passage in listing", %{conn: conn, passage: passage} do
      {:ok, index_live, _html} = live(conn, Routes.passage_index_path(conn, :index))

      assert index_live |> element("#passage-#{passage.id} a", "Delete") |> render_click()
      refute has_element?(index_live, "#passage-#{passage.id}")
    end
  end

  describe "Show" do
    setup [:create_passage]

    test "displays passage", %{conn: conn, passage: passage} do
      {:ok, _show_live, html} = live(conn, Routes.passage_show_path(conn, :show, passage))

      assert html =~ "Show Passage"
      assert html =~ passage.phrase
    end

    test "updates passage within modal", %{conn: conn, passage: passage} do
      {:ok, show_live, _html} = live(conn, Routes.passage_show_path(conn, :show, passage))

      assert show_live |> element("a", "Edit") |> render_click() =~
               "Edit Passage"

      assert_patch(show_live, Routes.passage_show_path(conn, :edit, passage))

      assert show_live
             |> form("#passage-form", passage: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      {:ok, _, html} =
        show_live
        |> form("#passage-form", passage: @update_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.passage_show_path(conn, :show, passage))

      assert html =~ "Passage updated successfully"
      assert html =~ "some updated phrase"
    end
  end
end
