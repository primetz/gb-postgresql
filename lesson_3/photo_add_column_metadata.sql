ALTER TABLE photo
    ADD COLUMN metadata json;

UPDATE photo
SET metadata = json_build_object(
        'id', id,
        'url', url,
        'size', size
    );
