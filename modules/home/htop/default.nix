{ config, pkgs, ... }:

{
  programs.htop = {
    enable = true;
    settings = {
      htop_version = "3.4.0-dev";
      config_reader_min_version = 3;
      fields = [ 0 48 17 18 38 39 40 2 46 47 49 1 ];
      hide_kernel_threads = true;
      hide_userland_threads = false;
      hide_running_in_container = false;
      shadow_other_users = false;
      show_thread_names = false;
      show_program_path = true;
      highlight_base_name = false;
      highlight_deleted_exe = true;
      shadow_distribution_path_prefix = false;
      highlight_megabytes = true;
      highlight_threads = true;
      highlight_changes = false;
      highlight_changes_delay_secs = 5;
      find_comm_in_cmdline = true;
      strip_exe_from_cmdline = true;
      show_merged_command = false;
      header_margin = 1;
      screen_tabs = true;
      detailed_cpu_time = false;
      cpu_count_from_one = false;
      show_cpu_usage = true;
      show_cpu_frequency = false;
      show_cpu_temperature = false;
      degree_fahrenheit = false;
      show_cached_memory = true;
      update_process_names = false;
      account_guest_in_cpu_meter = false;
      color_scheme = 0;
      enable_mouse = true;
      delay = 15;
      hide_function_bar = false;
      header_layout = "two_50_50";
      column_meters_0 = "LeftCPUs2 Memory Swap";
      column_meter_modes_0 = [ 1 1 1 ];
      column_meters_1 = "RightCPUs2 Tasks LoadAverage Uptime";
      column_meter_modes_1 = [ 1 2 2 2 ];
      tree_view = false;
      sort_key = 46;
      tree_sort_key = 0;
      sort_direction = -1;
      tree_sort_direction = 1;
      tree_view_always_by_pid = false;
      all_branches_collapsed = false;

      # Schermata Main
      "screen:Main" = "PID USER PRIORITY NICE M_VIRT M_RESIDENT M_SHARE STATE PERCENT_CPU PERCENT_MEM TIME Command";
      "screen:Main.sort_key" = "PERCENT_CPU";
      "screen:Main.tree_sort_key" = "PID";
      "screen:Main.tree_view_always_by_pid" = false;
      "screen:Main.tree_view" = false;
      "screen:Main.sort_direction" = -1;
      "screen:Main.tree_sort_direction" = 1;
      "screen:Main.all_branches_collapsed" = false;

      # Schermata I/O
      "screen:I/O" = "PID USER IO_PRIORITY IO_RATE IO_READ_RATE IO_WRITE_RATE PERCENT_SWAP_DELAY PERCENT_IO_DELAY Command";
      "screen:I/O.sort_key" = "IO_RATE";
      "screen:I/O.tree_sort_key" = "PID";
      "screen:I/O.tree_view_always_by_pid" = false;
      "screen:I/O.tree_view" = false;
      "screen:I/O.sort_direction" = -1;
      "screen:I/O.tree_sort_direction" = 1;
      "screen:I/O.all_branches_collapsed" = false;
    };
  };
}