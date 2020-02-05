
<div class="pagenation_w" style="margin-top:8px;">
	<div style="display:inline-block">
		<?php echo $pages['page_index_html'];//ページ目次 ?>
	</div>
	<div id='pagenation_jump' 
		data-row-limit='<?php echo $pages['row_limit']; ?>' 
		data-count='<?php echo $data_count; ?>' 
		data-hina-url='<?php echo $pages['def_url']; ?>' 
		style="display:inline-block"></div>
	<div style="display:inline-block">件数:<?php echo $data_count ?></div>
</div>