defmodule PetalComponents.Form do
  use Phoenix.Component
  import Phoenix.HTML.Form

  @moduledoc """
  Everything related to forms: inputs, labels etc
  """

  # prop form, :any
  # prop field, :any
  # prop label, :string
  # prop class, :css_class
  # slot default
  def form_label(assigns) do
    assigns = assigns
      |> assign_new(:classes, fn -> label_classes(assigns) end)
      |> assign_new(:form, fn -> nil end)
      |> assign_new(:has_error, fn -> false end)
      |> assign_new(:field, fn -> nil end)
      |> assign_new(:inner_block, fn -> nil end)
      |> assign_new(:label, fn ->
        if assigns[:field] do
          humanize(assigns[:field])
        else
          nil
        end
      end)
      |> assign_new(:label_opts, fn ->
        Map.drop(assigns, [
          :classes,
          :form,
          :field,
          :inner_block,
          :label,
          :__changed__
        ])
      end)

    ~H"""
    <%= if @form && @field do %>
      <%= label @form, @field, [class: @classes] ++ Map.to_list(@label_opts) do %>
        <%= if @inner_block do %>
          <%= render_slot(@inner_block) %>
        <% else %>
          <%= @label %>
        <% end %>
      <% end %>
    <% else %>
      <label class={@classes} {@label_opts}>
        <%= if @inner_block do %>
          <%= render_slot(@inner_block) %>
        <% else %>
          <%= @label %>
        <% end %>
      </label>
    <% end %>
    """
  end

  # prop form, :any, required: true
  # prop field, :any, required: true
  # prop type, :string, required: true, options: ["text_input", "email_input", "number_input", "password_input", "search_input", "telephone_input", "url_input", "time_input", "time_select", "datetime_local_input", "datetime_select", "color_input", "file_input", "range_input", "textarea", "select", "checkbox", "radio_gro"]
  # prop label, :string

  @doc "Use this when you want to include the label and some margin."
  def form_field(assigns) do
    assigns = assigns
    |> assign_new(:input_opts, fn ->
      Map.drop(assigns, [:form, :field, :label, :field_type])
    end)
    |> assign_new(:label, fn ->
      if assigns[:field] do
        humanize(assigns[:field])
      else
        nil
      end
    end)

    ~H"""
    <div class="mb-6">
      <%= case @type do %>
        <% "checkbox" -> %>
          <label class="inline-flex items-center block gap-3">
            <.checkbox form={@form} field={@field} {@input_opts} />
            <div class={label_classes(%{form: @form, field: @field, type: "checkbox"})}><%= @label %></div>
          </label>
        <% "radio_group" -> %>
          <.form_label form={@form} field={@field} label={@label} />
          <.radio_group form={@form} field={@field} {@input_opts} />
        <% "text_input" -> %>
          <.form_label form={@form} field={@field} label={@label} />
          <.text_input form={@form} field={@field} {@input_opts} />
        <% "email_input" -> %>
          <.form_label form={@form} field={@field} label={@label} />
          <.email_input form={@form} field={@field} {@input_opts} />
        <% "number_input" -> %>
          <.form_label form={@form} field={@field} label={@label} />
          <.number_input form={@form} field={@field} {@input_opts} />
        <% "password_input" -> %>
          <.form_label form={@form} field={@field} label={@label} />
          <.password_input form={@form} field={@field} {@input_opts} />
        <% "search_input" -> %>
          <.form_label form={@form} field={@field} label={@label} />
          <.search_input form={@form} field={@field} {@input_opts} />
        <% "telephone_input" -> %>
          <.form_label form={@form} field={@field} label={@label} />
          <.telephone_input form={@form} field={@field} {@input_opts} />
        <% "url_input" -> %>
          <.form_label form={@form} field={@field} label={@label} />
          <.url_input form={@form} field={@field} {@input_opts} />
        <% "time_input" -> %>
          <.form_label form={@form} field={@field} label={@label} />
          <.time_input form={@form} field={@field} {@input_opts} />
        <% "time_select" -> %>
          <.form_label form={@form} field={@field} label={@label} />
          <.time_select form={@form} field={@field} {@input_opts} />
        <% "datetime_select" -> %>
          <.form_label form={@form} field={@field} label={@label} />
          <.datetime_select form={@form} field={@field} {@input_opts} />
        <% "datetime_local_input" -> %>
          <.form_label form={@form} field={@field} label={@label} />
          <.datetime_local_input form={@form} field={@field} {@input_opts} />
        <% "color_input" -> %>
          <.form_label form={@form} field={@field} label={@label} />
          <.color_input form={@form} field={@field} {@input_opts} />
        <% "file_input" -> %>
          <.form_label form={@form} field={@field} label={@label} />
          <.file_input form={@form} field={@field} {@input_opts} />
        <% "range_input" -> %>
          <.form_label form={@form} field={@field} label={@label} />
          <.range_input form={@form} field={@field} {@input_opts} />
        <% "textarea" -> %>
          <.form_label form={@form} field={@field} label={@label} />
          <.textarea form={@form} field={@field} {@input_opts} />
        <% "select" -> %>
          <.form_label form={@form} field={@field} label={@label} />
          <.select form={@form} field={@field} {@input_opts} />
      <% end %>

      <.form_field_error class="mt-1" form={@form} field={@field} />
    </div>
    """
  end

  def text_input(assigns) do
    assigns = assign_defaults(assigns, text_input_classes(field_has_errors?(assigns)))

    ~H"""
    <%= text_input @form, @field, [class: @classes] ++ @input_attributes %>
    """
  end

  def email_input(assigns) do
    assigns = assign_defaults(assigns, text_input_classes(field_has_errors?(assigns)))

    ~H"""
    <%= email_input @form, @field, [class: @classes] ++ @input_attributes %>
    """
  end

  def number_input(assigns) do
    assigns = assign_defaults(assigns, text_input_classes(field_has_errors?(assigns)))

    ~H"""
    <%= number_input @form, @field, [class: @classes] ++ @input_attributes %>
    """
  end

  def password_input(assigns) do
    assigns = assign_defaults(assigns, text_input_classes(field_has_errors?(assigns)))

    ~H"""
    <%= password_input @form, @field, [class: @classes] ++ @input_attributes %>
    """
  end

  def search_input(assigns) do
    assigns = assign_defaults(assigns, text_input_classes(field_has_errors?(assigns)))

    ~H"""
    <%= search_input @form, @field, [class: @classes] ++ @input_attributes %>
    """
  end

  def telephone_input(assigns) do
    assigns = assign_defaults(assigns, text_input_classes(field_has_errors?(assigns)))

    ~H"""
    <%= telephone_input @form, @field, [class: @classes] ++ @input_attributes %>
    """
  end

  def url_input(assigns) do
    assigns = assign_defaults(assigns, text_input_classes(field_has_errors?(assigns)))

    ~H"""
    <%= url_input @form, @field, [class: @classes] ++ @input_attributes %>
    """
  end

  def time_input(assigns) do
    assigns = assign_defaults(assigns, text_input_classes(field_has_errors?(assigns)))

    ~H"""
    <%= time_input @form, @field, [class: @classes] ++ @input_attributes %>
    """
  end

  def time_select(assigns) do
    assigns = assign_defaults(assigns, text_input_classes(field_has_errors?(assigns)))

    ~H"""
    <%= time_select @form, @field, [class: @classes] ++ @input_attributes %>
    """
  end

  def datetime_local_input(assigns) do
    assigns = assign_defaults(assigns, text_input_classes(field_has_errors?(assigns)))

    ~H"""
    <%= datetime_local_input @form, @field, [class: @classes] ++ @input_attributes %>
    """
  end

  def datetime_select(assigns) do
    assigns = assign_defaults(assigns, text_input_classes(field_has_errors?(assigns)))

    ~H"""
    <%= datetime_select @form, @field, [class: @classes] ++ @input_attributes %>
    """
  end

  def color_input(assigns) do
    assigns = assign_defaults(assigns, color_input_classes(field_has_errors?(assigns)))

    ~H"""
    <%= color_input @form, @field, [class: @classes] ++ @input_attributes %>
    """
  end

  def file_input(assigns) do
    assigns = assign_defaults(assigns, file_input_classes(field_has_errors?(assigns)))

    ~H"""
    <%= file_input @form, @field, [class: @classes] ++ @input_attributes %>
    """
  end

  def range_input(assigns) do
    assigns = assign_defaults(assigns, range_input_classes(field_has_errors?(assigns)))

    ~H"""
    <%= range_input @form, @field, [class: @classes] ++ @input_attributes %>
    """
  end

  def textarea(assigns) do
    assigns = assign_defaults(assigns, text_input_classes(field_has_errors?(assigns)))

    ~H"""
    <%= textarea @form, @field, [class: @classes] ++ Keyword.merge([rows: "4"], @input_attributes) %>
    """
  end

  def select(assigns) do
    assigns = assign_defaults(assigns, select_classes(field_has_errors?(assigns)))

    ~H"""
    <%= select @form, @field, @options, [class: @classes] ++ @input_attributes %>
    """
  end

  def checkbox(assigns) do
    assigns = assign_defaults(assigns, checkbox_classes(field_has_errors?(assigns)))

    ~H"""
    <%= checkbox @form, @field, [class: @classes] ++ @input_attributes %>
    """
  end

  def radio(assigns) do
    assigns = assign_defaults(assigns, radio_classes(field_has_errors?(assigns)))

    ~H"""
    <%= radio_button @form, @field, @value, [class: @classes] ++ @input_attributes %>
    """
  end

  def radio_group(assigns) do
    assigns = assign_defaults(assigns, radio_classes(field_has_errors?(assigns)))

    ~H"""
    <div class="flex flex-col gap-1">
      <%= for {label, value} <- @options do %>
        <label class="inline-flex items-center block gap-3">
          <.radio form={@form} field={@field} value={value} {@input_attributes} />
          <div class={label_classes(%{form: @form, field: @field, type: "radio"})}><%= label %></div>
        </label>
      <% end %>
    </div>
    """
  end

  # <.form_field_error form={f} field={:name} />
  def form_field_error(assigns) do
    assigns = assign_new(assigns, :class, fn -> "" end)
    translate_error = translator_from_config() || (&translate_error/1)

    ~H"""
    <div class={@class}>
      <%= for error <- Keyword.get_values(@form.errors, @field) do %>
        <div class="text-xs italic text-red-500" phx-feedback-for={input_name(@form, @field)}>
          <%= translate_error.(error) %>
        </div>
      <% end %>
    </div>
    """
  end

  defp translate_error({msg, opts}) do
    # Because the error messages we show in our forms and APIs
    # are defined inside Ecto, we need to translate them dynamically.
    Enum.reduce(opts, msg, fn {key, value}, acc ->
      try do
        String.replace(acc, "%{#{key}}", to_string(value))
      rescue
        e ->
          IO.warn(
            """
            the fallback message translator for the form_field_error function cannot handle the given value.

            Hint: you can set up the `error_translator_function` to route all errors to your application helpers:

              config :petal_components, :error_translator_function, {MyAppWeb.ErrorHelpers, :translate_error}

            Given value: #{inspect(value)}

            Exception: #{Exception.message(e)}
            """,
            __STACKTRACE__
          )

          "invalid value"
      end
    end)
  end

  defp translator_from_config do
    case Application.get_env(:petal_components, :error_translator_function) do
      {module, function} -> &apply(module, function, [&1])
      nil -> nil
    end
  end

  defp assign_defaults(assigns, base_classes) do
    assigns
    |> assign_new(:type, fn -> "text" end)
    |> assign_new(:input_attributes, fn ->
      Map.drop(assigns, [
        :label,
        :form,
        :field,
        :type,
        :options,
        :__changed__
      ])
      |> Map.to_list()
    end)
    |> assign_new(:classes, fn ->
      [
        base_classes,
        assigns[:class] || ""
      ]
      |> Enum.join(" ")
    end)
  end

  defp label_classes(assigns) do
    type_classes =
      if Enum.member?(["checkbox", "radio"], assigns[:type]) do
        ""
      else
        "mb-2 font-medium"
      end

    error_classes = if field_has_errors?(assigns) do
      "text-red-900 dark:text-red-200"
    else
      "text-gray-900 dark:text-gray-200"
    end

    "#{type_classes} #{error_classes} text-sm block"
  end

  defp text_input_classes(has_error) do
    "#{get_error_classes(has_error)} sm:text-sm block shadow-sm w-full rounded-md dark:bg-gray-800 dark:text-gray-300 focus:outline-none focus:ring-primary-500 focus:border-primary-500"
  end

  defp select_classes(has_error) do
    "#{get_error_classes(has_error)} block w-full pl-3 pr-10 py-2 text-base focus:outline-none sm:text-sm rounded-md"
  end

  def file_input_classes(has_error) do
    get_error_classes(has_error)
  end

  def color_input_classes(has_error) do
    get_error_classes(has_error)
  end

  def range_input_classes(has_error) do
    "#{get_error_classes(has_error)} w-full"
  end

  defp checkbox_classes(has_error) do
    error_classes = if has_error, do: "border-red-500 text-red-900 dark:text-red-200", else: "border-gray-300 text-primary-700"
    "#{error_classes} rounded w-5 h-5 ease-linear transition-all duration-150"
  end

  defp radio_classes(has_error) do
    error_classes = if has_error, do: "border-red-500", else: "border-gray-300"
    "#{error_classes} h-4 w-4 cursor-pointer text-primary-600 focus:ring-primary-500"
  end

  defp get_error_classes(true), do: "border-red-500 focus:border-red-500 text-red-900 placeholder-red-700 bg-red-50"
  defp get_error_classes(false), do: "border-gray-300 focus:border-primary-500 focus:ring-primary-500 dark:border-gray-600 dark:focus:border-primary-500"

  defp field_has_errors?(%{form: form, field: field}) do
    length(Keyword.get_values(form.errors, field)) > 0
  end

  defp field_has_errors?(_), do: false
end