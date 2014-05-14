-- Cleans up any data that might be remnant after a run of the RelationshipGeneratorPluginIntegrationTest,
-- particularly if the run fails for some reason, it might not execute its tearDown() and can leave remnant
-- data in the database.

delete from ca.ca_attribute_values where value_id > 14;

delete from ca.ca_attributes where table_num = 57 and element_id = 70 and row_id > 46;

delete from ca.ca_attributes where table_num = 13 and element_id in (22,40) and row_id > 236;

delete from ca.ca_metadata_type_restrictions where table_num = 57 and element_id = 70 and type_id > 1421;

delete from ca.ca_objects_x_collections where object_id >= 34;

delete from ca.ca_object_labels where object_id >= 34;

delete from ca.ca_objects where object_id >= 34;

delete from ca.ca_collection_labels where collection_id > 2;

delete from ca.ca_collections where collection_id > 2;

delete FROM ca.ca_list_item_labels where name_singular like 'test_%';

delete from ca.ca_list_items where list_id in ( 6, 27 ) and idno like '%_test_%';

